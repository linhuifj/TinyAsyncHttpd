/*
 * AsynHttpSer.cpp
 *
 *  Created on: Mar 27, 2014
 *      Author: linhui
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <signal.h>
#include <fcntl.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/sysinfo.h>
#include "AsynHttpSer.h"
#include <event2/http_struct.h>
//#include <glog/logging.h>
#include <evhttp.h>
#include <sys/timeb.h>
#include <http-internal.h>
#include <event2/bufferevent.h>
#include <event2/bufferevent_ssl.h>


AsynHttpSer::AsynHttpSer(int nthreads, bool _asynproc) {
	capem_path = 0;
	privpem_path = 0;

	if (nthreads <= 0) {
		nthreads = get_nprocs();
	}
	signal(SIGPIPE, SIG_IGN);
	evthread_use_pthreads();
	size = nthreads*2;
	tids = new pthread_t[size + nthreads];
	bases = new struct event_base*[size];
	httpds = new struct evhttp*[size];
	for (int i = 0; i < size; ++i) {
		bases[i] = event_base_new();
		httpds[i] = evhttp_new(bases[i]);
	}

	asynproc = _asynproc;
	defaultCbData = 0;

	pthread_mutex_init(&lock, 0);
	pthread_cond_init(&cond, 0);

	if (asynproc) {
		for (int i = 0; i < nthreads; ++i) {
			pthread_create(&tids[size + i], 0, _queueWorker, this);
		}
	}
}

void AsynHttpSer::useHttps(const char * cert_pem, const char * priv_pem){
	capem_path = cert_pem;
	privpem_path = priv_pem;
	https_common_setup();

	for(int i=size/2; i< size; ++i){
		set_https(httpds[i], capem_path, privpem_path);
	}
}

void AsynHttpSer::setHandler(const char * uri, httpcb cb, void *arg) {
	if (uri == 0) {
		for (int i = 0; i < size; ++i) {
			evhttp_set_gencb(httpds[i], cb, arg);
		}
	} else {
		for (int i = 0; i < size; ++i) {
			evhttp_set_cb(httpds[i], uri, cb, arg);
		}
	}
}

void AsynHttpSer::setHandler(const char * uri, httpcb2 cb, void *arg) {
	if (uri == 0) {
		for (int i = 0; i < size; ++i) {
			EvCbData * data = new EvCbData();
			data->evbase = bases[i];
			data->ser = this;
			evhttp_set_gencb(httpds[i], defaultCb, data);
		}
		defaultCbData = new CallbackData(cb, arg);
	} else {
		for (int i = 0; i < size; ++i) {
			EvCbData * data = new EvCbData();
			data->evbase = bases[i];
			data->ser = this;
			evhttp_set_cb(httpds[i], uri, defaultCb, data);
		}
		cbDatas[uri] = new CallbackData(cb, arg);
	}
}

AsynHttpSer::~AsynHttpSer() {
	wait();
	for (int i = 0; i < size; ++i) {
		evhttp_free(httpds[i]);
		event_base_free(bases[i]);
	}
	delete[] httpds;
	delete[] bases;
	delete[] tids;
}

void AsynHttpSer::getargs(struct evhttp_request *req,
		map<const string, string>& wantedStrings,
		map<const string, vector<string> >& wantedVecStrings) {
	if (!req) {
		return;
	}

	struct evkeyvalq kv;
	TAILQ_INIT(&kv);

	evhttp_cmd_type reqType = evhttp_request_get_command(req);
	if (reqType == EVHTTP_REQ_GET) {
		const char * encoded_uri = evhttp_request_get_uri(req);
		if (!encoded_uri) {
			return;
		}
		int r = evhttp_parse_query(encoded_uri, &kv);
		if (0 != r) {
			return;
		}
	} else if (reqType == EVHTTP_REQ_POST) {
		struct evbuffer *buf = evhttp_request_get_input_buffer(req);
		evbuffer_add(buf, "", 1); /* NUL-terminate the buffer */
		char *payload = (char *) evbuffer_pullup(buf, -1);
		if (0 != evhttp_parse_query_str(payload, &kv)) {
			return;
		}
	}

	for (map<const string, string>::iterator it = wantedStrings.begin();
			it != wantedStrings.end(); it++) {
		const char* result = evhttp_find_header(&kv, (it->first).c_str());
		if (result != NULL) {
			it->second.assign(result);
			evhttp_remove_header(&kv, it->first.c_str());
		}
	}

	for (map<const string, vector<string> >::iterator vit =
			wantedVecStrings.begin(); vit != wantedVecStrings.end(); vit++) {
		bool found = true;
		do {
			const char* result = evhttp_find_header(&kv, (vit->first).c_str());
			if (result != NULL) {
				found = true;
				vit->second.push_back(string(result));
				evhttp_remove_header(&kv, vit->first.c_str());
			} else {
				found = false;
			}
		} while (found);
	}
	evhttp_clear_headers(&kv);
}

struct bufferevent* AsynHttpSer::bevcb(struct event_base *base, void *arg) {
	struct bufferevent* r;
	SSL_CTX *ctx = (SSL_CTX *) arg;

	r = bufferevent_openssl_socket_new(base, -1, SSL_new(ctx),
			BUFFEREVENT_SSL_ACCEPTING, BEV_OPT_CLOSE_ON_FREE);
	return r;
}

void AsynHttpSer::server_setup_certs(SSL_CTX *ctx,
		const char *certificate_chain, const char *private_key) {
	if (1 != SSL_CTX_use_certificate_chain_file(ctx, certificate_chain)) {
		fprintf(stderr, "SSL_CTX_use_certificate_chain_file");
		ERR_print_errors_fp(stderr);
		abort();
	}

	if (1 != SSL_CTX_use_PrivateKey_file(ctx, private_key, SSL_FILETYPE_PEM)) {
		fprintf(stderr, "SSL_CTX_use_PrivateKey_file");
		ERR_print_errors_fp(stderr);
		abort();
	}

	if (1 != SSL_CTX_check_private_key(ctx)) {
		fprintf(stderr, "SSL_CTX_check_private_key");
		ERR_print_errors_fp(stderr);
		abort();
	}
}

void AsynHttpSer::example_handler(struct evhttp_request *req, void *arg) {
	usleep(100 * 1000);
	struct evbuffer * evb = evbuffer_new();
	static int i = 0;
	evbuffer_add_printf(evb, "%s-%d\n", "hello world", i++);
	evhttp_add_header(evhttp_request_get_output_headers(req), "Content-Type",
			"text/html");
	evhttp_add_header(evhttp_request_get_output_headers(req), "Connection",
			"close");
	evhttp_send_reply(req, 200, "OK", evb);
	evbuffer_free(evb);
}

void AsynHttpSer::example_queue_handler(struct ReqData *req, void *arg) {
	usleep(100 * 1000);
	struct evbuffer *buf = evbuffer_new();
	static int i = 0;
	evbuffer_add_printf(buf, "ok-%d\n", i++);
	req->result = buf;
}

void AsynHttpSer::printListenInfo(int fd) {
	struct sockaddr_storage ss;
	ev_socklen_t socklen = sizeof(ss);
	char addrbuf[128];
	void *inaddr;
	const char *addr;
	int got_port = -1;
	memset(&ss, 0, sizeof(ss));
	if (getsockname(fd, (struct sockaddr *) &ss, &socklen)) {
		//LOG(FATAL) << "getsockname() failed" << endl;
	}
	if (ss.ss_family == AF_INET) {
		got_port = ntohs(((struct sockaddr_in*) &ss)->sin_port);
		inaddr = &((struct sockaddr_in*) &ss)->sin_addr;
	} else if (ss.ss_family == AF_INET6) {
		got_port = ntohs(((struct sockaddr_in6*) &ss)->sin6_port);
		inaddr = &((struct sockaddr_in6*) &ss)->sin6_addr;
	} else {
		//LOG(FATAL) << "Weird address family " << ss.ss_family << endl;
	}
	addr = evutil_inet_ntop(ss.ss_family, inaddr, addrbuf, sizeof(addrbuf));
	if (addr) {
		//LOG(INFO) << "Listening on " << addr << ":" << got_port << endl;
	} else {
		//LOG(FATAL) << "evutil_inet_ntop failed\n";
	}
}

void AsynHttpSer::setMaxQueueLen(int len) {
	maxQueueLen = len;
}

string AsynHttpSer::getclientip(struct evhttp_request *req) {
	char * ip;
	unsigned short port;
	evhttp_connection_get_peer(req->evcon, &ip, &port);
	return ip;
}

int AsynHttpSer::bind_socket(int port, int backlog) {
	int r;
	int nfd;
	nfd = socket(AF_INET, SOCK_STREAM, 0);
	if (nfd < 0)
		return -1;

	int one = 1;
	r = setsockopt(nfd, SOL_SOCKET, SO_REUSEADDR, (char *) &one, sizeof(int));

	struct sockaddr_in addr;
	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = INADDR_ANY;
	addr.sin_port = htons(port);

	r = bind(nfd, (struct sockaddr*) &addr, sizeof(addr));
	if (r < 0)
		return -1;
	r = listen(nfd, backlog);
	if (r < 0)
		return -1;

	int flags;
	if ((flags = fcntl(nfd, F_GETFL, 0)) < 0
			|| fcntl(nfd, F_SETFL, flags | O_NONBLOCK) < 0)
		return -1;

	return nfd;
}

int AsynHttpSer::start(int port) {
	int r, i;
	int nfd = bind_socket(port);

	if (nfd <= 0) {
		fprintf(stderr,"cannot bind on port %d\n", port);
		return -1;
	}

	int lastend = size/2;
	int nfd1 = 0;
	if(this->capem_path == 0 || this->privpem_path == 0){
		lastend = size;
	} else {
		nfd1 = bind_socket(port + 1);
		if(nfd1 <= 0){
			fprintf(stderr,"cannot bind on port %d\n", port+1);
			return -1;
		}
	}

	for (i = 0; i < lastend; i++) {
		r = evhttp_accept_socket(httpds[i], nfd);
		if (r != 0)
			return -1;
		r = pthread_create(&tids[i], NULL, dispatchThread, bases[i]);
		if (r != 0)
			return -1;
	}

	for (i = lastend; i < size; i++) {
		r = evhttp_accept_socket(httpds[i], nfd1);
		if (r != 0)
			return -1;
		r = pthread_create(&tids[i], NULL, dispatchThread, bases[i]);
		if (r != 0)
			return -1;
	}

	return port;
}

void * AsynHttpSer::dispatchThread(void * arg) {
	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL); //允许退出线程
	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL); //设置立即取消
	struct event_base *evbase = (struct event_base*) arg;
	event_base_dispatch(evbase);
	//never come here!
	return 0;
}

void AsynHttpSer::wait() {
	for (int i = 0; i < size; ++i) {
		pthread_join(tids[i], 0);
	}
}

void AsynHttpSer::onDisconnect(struct evhttp_connection *evcon, void *arg) {
	struct ReqData * req = (struct ReqData*) arg;
	req->lock();
	req->connected = false;
	req->unlock();
}

void AsynHttpSer::defaultCb(struct evhttp_request *req, void *arg) {
	EvCbData * argdata = (EvCbData*) arg;
	AsynHttpSer * ser = argdata->ser;
	ReqData * reqdata = new ReqData();
	reqdata->evbase = argdata->evbase;
	reqdata->req = req;
	reqdata->starttime = millsec();

	bufferevent_enable(req->evcon->bufev, EV_READ);
	evhttp_connection_set_closecb(req->evcon, onDisconnect, reqdata);
	//	evhttp_send_reply_start(req, HTTP_OK, "OK");
	//evhttp_send_reply_start(req, 100, "Continue");

	bool flag = false;
	pthread_mutex_lock(&ser->lock);
	ser->reqQueue.push(reqdata);
	flag = ser->reqQueue.size() == 1;
	pthread_mutex_unlock(&ser->lock);
	if (flag) {
		pthread_cond_broadcast(&ser->cond);
	}
}

void AsynHttpSer::finishWork(ReqData *reqdata) {
	reqdata->e = evtimer_new(reqdata->evbase, replyCb, reqdata);
	struct timeval timeoutx;
	timeoutx.tv_sec = -1;
	timeoutx.tv_usec = 0;
	evtimer_add(reqdata->e, &timeoutx);
}

void * AsynHttpSer::_queueWorker(void * arg) {
	AsynHttpSer * ser = (AsynHttpSer*) arg;
	while (true) {
		ReqData * reqdata = 0;
//		while (pthread_mutex_trylock(&ser->lock))
//			;
		pthread_mutex_lock(&ser->lock);
		while (ser->reqQueue.size() == 0) {
			pthread_cond_wait(&ser->cond, &ser->lock);
		}
		reqdata = ser->reqQueue.front();
		ser->reqQueue.pop();
		pthread_mutex_unlock(&ser->lock);
		bool flag = false;
		reqdata->lock();
		if (reqdata->connected) {
			char uri[1024] = { 0 };
			strncpy(uri, reqdata->req->uri, 1023);
			char * p = strstr(uri, "?");
			if (p)
				*p = 0;
			CallbackData* cbData = ser->cbDatas[uri];
			if (cbData == 0)
				cbData = ser->defaultCbData;
			if (cbData && cbData->cb) {
				//return 1 说明出错，要立即返回的
				if (cbData->cb(reqdata, cbData->arg)){
					finishWork(reqdata);
				}
				flag = true;
			}
		} else {
			if (reqdata->req->evcon) {
				evhttp_connection_set_closecb(reqdata->req->evcon, NULL, NULL);
			}
			evhttp_send_reply_end(reqdata->req);
		}
		reqdata->unlock();
		if (!flag) {
			//flag=true代表这些数据会在后面回调过程中删除，不要在这里删除
			delete reqdata;
		}
	}
	return 0;
}

void AsynHttpSer::replyCb(int fd, short kind, void *userp) {
	ReqData * reqdata = (ReqData*) userp;
	reqdata->lock();

	if (reqdata->connected) {
		evhttp_add_header(reqdata->req->output_headers, "Connection", "close");
		evhttp_add_header(reqdata->req->output_headers, "Cache-Control", "no-cache");
		//evhttp_add_header(req->output_headers, "Expires", "0");
		evhttp_add_header(reqdata->req->output_headers, "Content-Type",
				"text/html; charset=utf-8");

		if(reqdata->status == 200){
			evhttp_send_reply_start(reqdata->req, 200, "OK");
		} else if(reqdata->status == 500){
			evhttp_send_reply_start(reqdata->req, 500, "Internal Server Error");
		} else if(reqdata->status == 400) {
			evhttp_send_reply_start(reqdata->req, 400, "Bad Request");
		} else {
			evhttp_send_reply_start(reqdata->req, 503, "Service Unavailable");
		}

		if (reqdata->req->evcon) {
			evhttp_connection_set_closecb(reqdata->req->evcon, NULL, NULL);
		}
		if (reqdata->req && reqdata->result) {
			evhttp_send_reply_chunk(reqdata->req, reqdata->result);
		}
		evhttp_send_reply_end(reqdata->req);
	}
	reqdata->unlock();
	delete reqdata;
}

int AsynHttpSer::queueLength() {
	return reqQueue.size();
}

static void *my_zeroing_malloc(size_t howmuch) {
	return calloc(1, howmuch);
}
void AsynHttpSer::https_common_setup() {
	CRYPTO_set_mem_functions(my_zeroing_malloc, realloc, free);
	SSL_library_init();
	SSL_load_error_strings();
	OpenSSL_add_all_algorithms ();
}

void AsynHttpSer::set_https(evhttp * httpd, const char * certificate_pem,
		const char * privatekey_pem) {
	SSL_CTX *ctx = SSL_CTX_new(SSLv23_server_method());
	SSL_CTX_set_options(ctx,
			SSL_OP_SINGLE_DH_USE | SSL_OP_SINGLE_ECDH_USE | SSL_OP_NO_SSLv2);
	EC_KEY *ecdh = EC_KEY_new_by_curve_name(NID_X9_62_prime256v1);

	if (!ecdh) {
		fprintf(stderr, "EC_KEY_new_by_curve_name");
		abort();
	}

	if (1 != SSL_CTX_set_tmp_ecdh(ctx, ecdh)) {
		fprintf(stderr, "SSL_CTX_set_tmp_ecdh");
		abort();
	}

	/* Find and set up our server certificate. */
	server_setup_certs(ctx, certificate_pem, privatekey_pem);

	/* This is the magic that lets evhttp use SSL. */
	evhttp_set_bevcb(httpd, bevcb, ctx);

}

#if TEST_ASYNHTTPSER
int main(int argc, char * argv[]) {
	AsynHttpSer httpser1(0, 1);
	httpser1.setHandler("/test1", AsynHttpSer::example_queue_handler, 0);
	httpser1.setHandler("/test2", AsynHttpSer::example_handler, 0);
	httpser1.start(9999);
	return 0;
}
#endif
