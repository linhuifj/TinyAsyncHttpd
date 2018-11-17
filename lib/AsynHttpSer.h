/*
 * AsynHttpSer.h
 *
 *  Created on: Mar 27, 2014
 *      Author: linhui
 */

#ifndef ASYNHTTPSER_H_
#define ASYNHTTPSER_H_

#include <event2/thread.h>
#include <event2/event.h>
#include <event2/http.h>
#include <event2/buffer.h>
#include <event2/util.h>
#include <event2/keyvalq_struct.h>
#include <pthread.h>
#include <map>
#include <string>
#include <vector>
#include <queue>

#include <openssl/ssl.h>
#include <openssl/err.h>

using namespace std;



typedef void (*httpcb)(struct evhttp_request *, void *);

struct ReqData {
	ReqData(bool _needlock = true) {
		needlock = _needlock;
		if (_needlock)
			pthread_mutex_init(&_lock, 0);
		connected = true;
		result = 0;
		e = 0;
		req = 0;
		starttime = 0;
		evbase = 0;
		status = 200;
	}
	~ReqData() {
		if (needlock) {
			pthread_mutex_destroy(&_lock);
		}
		if (e) {
			if (evtimer_pending(e, NULL)) {
				evtimer_del(e);
			}
			event_free(e);
		}
		if (result) {
			evbuffer_free(result);
		}
	}

	void lock() {
		pthread_mutex_lock(&_lock);
	}

	void unlock() {
		pthread_mutex_unlock(&_lock);
	}

	long starttime;
	struct evhttp_request * req;
	pthread_mutex_t _lock;
	bool connected;
	struct event_base * evbase;
	struct evbuffer * result;
	struct event * e;
	bool needlock;
	int status;
};

typedef int (*httpcb2)(struct ReqData *, void *);

struct CallbackData {
	CallbackData(httpcb2 _cb, void * _arg) {
		cb = _cb;
		arg = _arg;
	}

	httpcb2 cb;
	void * arg;
};

class AsynHttpSer {
public:
	/**
	 * nthreads:
	 *           num of thread, if nthreads = 0, use num of cpu core
	 *
	 * asynproc:
	 *           if set, requests are put in a queue and processed,
	 *           else requests are processed immediately
	 */
	AsynHttpSer(int nthreads = 0, bool asynproc = false);

	virtual ~AsynHttpSer();

	void setHandler(const char * uri, httpcb cb, void * arg);

	void setHandler(const char * uri, httpcb2 cb, void * arg);

	static void getargs(struct evhttp_request *req,
			map<const string, string>& wantedStrings,
			map<const string, vector<string> >& wantedVecStrings);

	static string getclientip(struct evhttp_request *req);

	static void example_handler(struct evhttp_request *req, void *arg);

	static void example_queue_handler(struct ReqData *req, void *arg);

	int bind_socket(int port, int backlog = 300000);

	int start(int port);

	void printListenInfo(int fd);

	int queueLength();

	void setMaxQueueLen(int len);

	static void replyCb(int fd, short kind, void *userp);

	void wait();

	static void finishWork(ReqData *reqdata);

	void useHttps(const char * cert_pem, const char * priv_pem);
private:
	static void set_https(evhttp * httpd, const char * certificate_pem,
			const char * privatekey_pem);

	static struct bufferevent* bevcb(struct event_base *base, void *arg);

	static void server_setup_certs(SSL_CTX *ctx, const char *certificate_chain,
			const char *private_key);

	static void * dispatchThread(void * arg);
	struct event_base ** bases;
	struct evhttp ** httpds;
	pthread_t * tids;
	int size;
	bool asynproc;

	static void https_common_setup();

	static void * _queueWorker(void * arg);

	static void defaultCb(struct evhttp_request *req, void *arg);

	static void onDisconnect(struct evhttp_connection *evcon, void *arg);

	int maxQueueLen;

	pthread_mutex_t lock;
	pthread_cond_t cond;
	queue<ReqData*> reqQueue;

	CallbackData * defaultCbData;
	map<string, CallbackData*> cbDatas;

	const char * capem_path;
	const char * privpem_path;
};

struct EvCbData {
	struct event_base * evbase;
	AsynHttpSer * ser;
};

long millsec();

#endif /* ASYNHTTPSER_H_ */
