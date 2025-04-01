for(int i=0; i<N; i+=2) {
  A[i] = B[i];
  C[i] = rand();
  A[i+1] = B[i+1];
  C[i+1] = rand();
}