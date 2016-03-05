package xmlpl.unistd 0.0.1;

__native__
#include <unistd.h>
#include <stdlib.h>

#ifndef PATH_MAX
#define PATH_MAX 1024
#endif
__native__

integer sleep(integer seconds) {
  __native__
    return sleep(XPL_seconds);
  __native__
}

integer usleep(integer usec) {
  __native__
    return usleep(XPL_usec);
  __native__
}

string getcwd() {
  __native__
  char buf[PATH_MAX];

  return String(getcwd(buf, PATH_MAX), true);
  __native__
}
