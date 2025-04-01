#pragma omp for unroll full
for(int i=0; i<4; ++i)
  A[i] += B[i] * c;