for(int i=0; i<N/2; i++) {
  A[i] = B[i];
  C[i] = rand();
}
for(int i=N/2; i<N; i++) {
  A[i] = B[i];
  C[i] = rand();
}