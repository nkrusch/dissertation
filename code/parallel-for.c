#pragma omp parallel for
for(int i=0; i<N; ++i)
  C[i] = A[i] + B[i];