#include <stdio.h>

/* printd - printf that takes a double prints it as "%f\n", returning the value. */
extern double printdub(double X) {
  printf("%f", X);
  return X;
}

extern double putchar_wrap(char str[]) {
  putchar(str);
  // printf("%c", str); TODO
  return 0.0;
}