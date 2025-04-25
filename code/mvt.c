void kernel_mvt(|$\dots$|){
  for (i=0; i<N; i++)
    for (j=0; j<N; j++)
      x1[i] = x1[i]+A[i][j]*y1[j];
  for (i=0; i<N; i++)
    for (j=0; j<N; j++)
      x2[i] = x2[i]+A[j][i]*y2[j];
}