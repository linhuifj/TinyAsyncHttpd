/**
 * Base64 encoder. Feel free to use however you see fit.
 * Written by Sergey Kolchin <ksa242@gmail.com>.
 * Based on implementation by Jim Meyering <metering@redhat.com>.
 */

#ifndef _C_BASE64_H_
#define _C_BASE64_H_

#ifdef __cplusplus
extern "C"
{
#endif  /* __cplusplus */

extern int b64encode(char **, const char *, size_t);

extern int b64decode(const char *src, char *dst, size_t dst_len);
//
//int base64_encode(const char *str,int str_len,char *encode,int encode_len);
//
//int base64_decode(char *str,int str_len,char *decode,int decode_buffer_len);

#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif  /* !_C_BASE64_H_ */
