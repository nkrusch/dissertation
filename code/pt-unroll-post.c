for(int i=0; i<n; i+=4) {
  A[i] += B[i] * c;
  if(i + 1 < n)
    A[i+1] += B[i+1] * c;
  if(i + 2 < n)
    A[i+2] += B[i+2] * c;
  if(i + 3 < n)
    A[i+3] += B[i+3] * c;
}