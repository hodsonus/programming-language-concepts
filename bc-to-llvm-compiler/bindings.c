#include <stdio.h>

/* printd - printf that takes a double prints it as "%f\n", returning the value. */
extern double printd(double X) {
  printf("%f\n", X);
  return X;
}