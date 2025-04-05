#pragma omp parallel for shared(A, B) private(i)
for (i=0; i<N; i++) {
  A[i]=i+1; B[i]=i*2;
}