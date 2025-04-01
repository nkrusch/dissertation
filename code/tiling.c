for(int j=0; j<N; j+=8) {
  for(int i=j; i<j+8; i++) {
    A[i] = B[i];
    C[i] = rand();
  }
}