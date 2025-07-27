int loop(int X1, int X2, int X3,
         int X4, int X5) {
  for(int i = 0; i < X1; i++) {
       X3 = X2 * X2;
       X3 = X3 + X5;
       X4 = X4 + X5;
  }
  return X3;
}