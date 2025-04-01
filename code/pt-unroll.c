#pragma omp for unroll partial(4)
for(int i=0; i<n; i+=1)
  A[i] += B[i] * c;