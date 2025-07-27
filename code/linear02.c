int loop(int x, int y) {
  y = 0;
  while(y < 1000) {
      x = x + y;
      y = y + 1;
  }
  return x;
}