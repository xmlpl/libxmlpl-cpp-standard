package xmlpl.curl 0.0.1;

__native__
#include <curl/curl.h>
__native__

string url_escape(string url) {
  __native__
  char *url = curl_escape(XPL_url.cstr(), 0);

  String result = String(url, true);
  curl_free(url);

  return result;
  __native__
}

string url_unescape(string url) {
  __native__
  char *url = curl_unescape(XPL_url.cstr(), 0);

  String result = String(url, true);
  curl_free(url);

  return result;
  __native__
}
