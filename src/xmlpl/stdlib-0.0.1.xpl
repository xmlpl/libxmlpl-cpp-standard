package xmlpl.stdlib 0.0.1;

__native__
#include <stdlib.h>
__native__

string getenv(string name) {
  __native__
  return getenv(XPL_name.cstr());
  __native__
}
