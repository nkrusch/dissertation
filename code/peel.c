A[0] = B[0]; C[0] = rand();
A[1] = B[1]; C[1] = rand();
for(int i=2; i<N; i++) {
  A[i] = B[i];
  C[i] = rand();
}