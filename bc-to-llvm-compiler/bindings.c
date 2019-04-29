#include <stdio.h>
#include <math.h>

/* printd - printf that takes a double prints it as "%f\n", returning the value. */
extern double printdub(double X) {
  printf("%f", X);
  return X;
}

extern double putchar_wrap(char str[]) {
  /* TODO, this is super fragile and i dont know why. Generates what SEEMS to
  be a harmless warning, not sure */
  printf("%c", str);
  return 0.0;
}