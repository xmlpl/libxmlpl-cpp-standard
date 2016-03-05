package xmlpl.math 0.0.1;

__native__
#include <math.h>
__native__

real sin(real x) {
  __native__
  return sin(XPL_x);
  __native__
}

real cos(real x) {
  __native__
  return cos(XPL_x);
  __native__
}

real tan(real x) {
  __native__
  return tan(XPL_x);
  __native__
}

integer round(real x) {
  __native__
  return (int)round(XPL_x);
  __native__
}
