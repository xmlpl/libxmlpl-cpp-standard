package xmlpl.time 0.0.1;

__native__
#include "time.h"
__native__

integer now() {
  __native__
  return time(0);
  __native__
}

integer strptime(string timeStr, string format) {
  __native__
  struct tm t;

  memset(&t, 0, sizeof(struct tm));

  if (!strptime(XPL_timeStr.cstr(), XPL_format.cstr(), &t))
    __native__
    throw "Invalid time string '" + timeStr + "' for format '" + format + "'";
    __native__

  return mktime(&t);
  __native__
}

string strftime(string format, integer time) {
  __native__
  time_t t = XPL_time;
  t = time(&t);
  struct tm *t2 = localtime(&t);
  char buffer[1024];
  buffer[0] = 0;

  strftime(buffer, 1024, XPL_format.cstr(), t2);

  return buffer;
  __native__
}
