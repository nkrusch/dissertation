method LucidLoop(X1: nat, X2: nat, X3: nat, X4: nat, X5: nat){

  // for bookkeeping -- record initial values
  var X1', X2', X3', X4', X5' := X1, X2, X3, X4, X5;

  for i := 0 to X1'
    // invariants (omitted)
  {
    X3' := X2' * X2' + X5';
    X4' := X4' + X5';
  }

  // postconditions
  assert X1'<= X1;                       // linear
  assert X2'<= X2;                       // linear
  assert X5'<= X5;                       // linear
  assert X3'<= Max(X3, X2*X2+X5);        // weak polynomial
  assert X4'<= X4+X1*X5;                 // polynomial
}