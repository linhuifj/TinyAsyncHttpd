#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <inttypes.h>
#include <ctype.h>
#include "base64.h"

static const char Base64[] =
		"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const char Pad64 = '=';

/* (From RFC1521 and draft-ietf-dnssec-secext-03.txt)
 The following encoding technique is taken from RFC 1521 by Borenstein
 and Freed.  It is reproduced here in a slightly edited form for
 convenience.

 A 65-character subset of US-ASCII is used, enabling 6 bits to be
 represented per printable character. (The extra 65th character, "=",
 is used to signify a special processing function.)

 The encoding process represents 24-bit groups of input bits as output
 strings of 4 encoded characters. Proceeding from left to right, a
 24-bit input group is formed by concatenating 3 8-bit input groups.
 These 24 bits are then treated as 4 concatenated 6-bit groups, each
 of which is translated into a single digit in the base64 alphabet.

 Each 6-bit group is used as an index into an array of 64 printable
 characters. The character referenced by the index is placed in the
 output string.

 Table 1: The Base64 Alphabet

 Value Encoding  Value Encoding  Value Encoding  Value Encoding
 0 A            17 R            34 i            51 z
 1 B            18 S            35 j            52 0
 2 C            19 T            36 k            53 1
 3 D            20 U            37 l            54 2
 4 E            21 V            38 m            55 3
 5 F            22 W            39 n            56 4
 6 G            23 X            40 o            57 5
 7 H            24 Y            41 p            58 6
 8 I            25 Z            42 q            59 7
 9 J            26 a            43 r            60 8
 10 K            27 b            44 s            61 9
 11 L            28 c            45 t            62 +
 12 M            29 d            46 u            63 /
 13 N            30 e            47 v
 14 O            31 f            48 w         (pad) =
 15 P            32 g            49 x
 16 Q            33 h            50 y

 Special processing is performed if fewer than 24 bits are available
 at the end of the data being encoded.  A full encoding quantum is
 always completed at the end of a quantity.  When fewer than 24 input
 bits are available in an input group, zero bits are added (on the
 right) to form an integral number of 6-bit groups.  Padding at the
 end of the data is performed using the '=' character.

 Since all base64 input is an integral number of octets, only the
 -------------------------------------------------
 following cases can arise:

 (1) the final quantum of encoding input is an integral
 multiple of 24 bits; here, the final unit of encoded
 output will be an integral multiple of 4 characters
 with no "=" padding,
 (2) the final quantum of encoding input is exactly 8 bits;
 here, the final unit of encoded output will be two
 characters followed by two "=" padding characters, or
 (3) the final quantum of encoding input is exactly 16 bits;
 here, the final unit of encoded output will be three
 characters followed by one "=" padding character.
 */
#ifdef WIN32
typedef unsigned char u_char;
#endif
#include <openssl/evp.h>
#include <openssl/bio.h>
#include <openssl/buffer.h>

#ifndef WIN32
int base64_encode(const char *str,int str_len,char *encode,int encode_len){
	BIO *bio;
	BIO *b64;
	FILE* stream;

	int encodedSize = 4*ceil((double)str_len/3);
	stream = fmemopen(encode, encodedSize+1, "w");
	b64 = BIO_new(BIO_f_base64());
	bio = BIO_new_fp(stream, BIO_NOCLOSE);
	bio = BIO_push(b64, bio);
	BIO_set_flags(bio, BIO_FLAGS_BASE64_NO_NL);
	BIO_write(bio, str, str_len);
	(void)BIO_flush(bio);
	BIO_free_all(bio);
	fclose(stream);
	return encodedSize;
}

int base64_decode(char *str,int str_len,char *decode,int decode_buffer_len){
    int len=0;
    BIO *b64,*bmem;
    b64=BIO_new(BIO_f_base64());
    bmem=BIO_new_mem_buf(str,str_len);
    bmem=BIO_push(b64,bmem);
    len=BIO_read(bmem,decode,str_len);
    decode[len]=0;
    BIO_free_all(bmem);
    return 0;
}
#endif

static int b64_encode(u_char const *src, size_t srclength, char *target,
		size_t targsize) {
	size_t datalength = 0;
	u_char input[3];
	u_char output[4];
	size_t i;

	while (2 < srclength) {
		input[0] = *src++;
		input[1] = *src++;
		input[2] = *src++;
		srclength -= 3;

		output[0] = input[0] >> 2;
		output[1] = ((input[0] & 0x03) << 4) + (input[1] >> 4);
		output[2] = ((input[1] & 0x0f) << 2) + (input[2] >> 6);
		output[3] = input[2] & 0x3f;

		if (datalength + 4 > targsize)
			return (-1);
		target[datalength++] = Base64[output[0]];
		target[datalength++] = Base64[output[1]];
		target[datalength++] = Base64[output[2]];
		target[datalength++] = Base64[output[3]];
	}

	/* Now we worry about padding. */
	if (0 != srclength) {
		/* Get what's left. */
		input[0] = input[1] = input[2] = '\0';
		for (i = 0; i < srclength; i++)
			input[i] = *src++;

		output[0] = input[0] >> 2;
		output[1] = ((input[0] & 0x03) << 4) + (input[1] >> 4);
		output[2] = ((input[1] & 0x0f) << 2) + (input[2] >> 6);

		if (datalength + 4 > targsize)
			return (-1);
		target[datalength++] = Base64[output[0]];
		target[datalength++] = Base64[output[1]];
		if (srclength == 1)
			target[datalength++] = Pad64;
		else
			target[datalength++] = Base64[output[2]];
		target[datalength++] = Pad64;
	}
	if (datalength >= targsize)
		return (-1);
	target[datalength] = '\0'; /* Returned value doesn't count \0. */
	return (datalength);
}

/* skips all whitespace anywhere.
 converts characters, four at a time, starting at (or after)
 src from base - 64 numbers into three 8 bit bytes in the target area.
 it returns the number of data bytes stored at the target, or -1 on error.
 */

static int b64_decode(char const *src, u_char *target, size_t targsize) {
	int tarindex, state, ch;
	const char *pos;

	state = 0;
	tarindex = 0;

	while ((ch = *src++) != '\0') {
		if (isspace(ch)) /* Skip whitespace anywhere. */
			continue;

		if (ch == Pad64)
			break;

		pos = strchr(Base64, ch);
		if (pos == 0) /* A non-base64 character. */
			return (-1);

		switch (state) {
		case 0:
			if (target) {
				if ((size_t) tarindex >= targsize)
					return (-1);
				target[tarindex] = (pos - Base64) << 2;
			}
			state = 1;
			break;
		case 1:
			if (target) {
				if ((size_t) tarindex + 1 >= targsize)
					return (-1);
				target[tarindex] |= (pos - Base64) >> 4;
				target[tarindex + 1] = ((pos - Base64) & 0x0f) << 4;
			}
			tarindex++;
			state = 2;
			break;
		case 2:
			if (target) {
				if ((size_t) tarindex + 1 >= targsize)
					return (-1);
				target[tarindex] |= (pos - Base64) >> 2;
				target[tarindex + 1] = ((pos - Base64) & 0x03) << 6;
			}
			tarindex++;
			state = 3;
			break;
		case 3:
			if (target) {
				if ((size_t) tarindex >= targsize)
					return (-1);
				target[tarindex] |= (pos - Base64);
			}
			tarindex++;
			state = 0;
			break;
		default:
			return -1;
		}
	}

	/*
	 * We are done decoding Base-64 chars.  Let's see if we ended
	 * on a byte boundary, and/or with erroneous trailing characters.
	 */

	if (ch == Pad64) { /* We got a pad char. */
		ch = *src++; /* Skip it, get next. */
		switch (state) {
		case 0: /* Invalid = in first position */
		case 1: /* Invalid = in second position */
			return (-1);

		case 2: /* Valid, means one byte of info */
			/* Skip any number of spaces. */
			for ((void) NULL; ch != '\0'; ch = *src++)
				if (!isspace(ch))
					break;
			/* Make sure there is another trailing = sign. */
			if (ch != Pad64)
				return (-1);
			ch = *src++; /* Skip the = */
			/* Fall through to "single trailing =" case. */
			/* FALLTHROUGH */

		case 3: /* Valid, means two bytes of info */
			/*
			 * We know this char is an =.  Is there anything but
			 * whitespace after it?
			 */
			for ((void) NULL; ch != '\0'; ch = *src++)
				if (!isspace(ch))
					return (-1);

			/*
			 * Now make sure for cases 2 and 3 that the "extra"
			 * bits that slopped past the last full byte were
			 * zeros.  If we don't check them, they become a
			 * subliminal channel.
			 */
			if (target && target[tarindex] != 0)
				return (-1);
		}
	} else {
		/*
		 * We ended by seeing the end of the string.  Make sure we
		 * have no partial bytes lying around.
		 */
		if (state != 0)
			return (-1);
	}

	return (tarindex);
}

int b64encode(char **dst, const char *src, size_t srclen) {
	size_t dstlen = 6 * ceil(srclen / 3.0) + 2;
	*dst = (char *) calloc(dstlen + 1, sizeof(char));
	memset(*dst, 0, dstlen+1);
	int len = b64_encode((unsigned char*) src, srclen, *dst, dstlen);
	if (len < 0)
		len = 0;
	return len;
}

int b64decode(const char *src, char*dst, size_t dst_len) {
	dst[0] = 0;
	int len = b64_decode(src, (unsigned char*) dst, dst_len);
	return len > 0 ? len : 0;
}

#ifdef TEST_BASE64
int main(int argc, char *argv[])
{
	char content[4096] = {0};
	char line[1024];
	while(fgets(line,1024,stdin)) {
		int n = strlen(line);
		//	if(line[n-1] == '\n'||line[n-1] == '\r')line[n-1]=0;
		strcat(content,line);
	}
	//fprintf(stderr,"%s\n",content);
	char content2[40960];
	int len = b64decode(content,content2);
	for(int i=0;i<len;++i)
	fprintf(stderr,"%c",content2[i]);
}
#endif  /* TEST_BASE64 */
