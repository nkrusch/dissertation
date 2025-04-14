/* proved automatically */
lemma Add0Left (n: nat)
  ensures 0 + n == n
{}

method Ok1(){
  assert 1 + 1 == 2;
}

predicate OK2() {
  true
}

method Failing1(i: nat){
  assert i > -1 ;
  var x := 1;
  assert x == 2;
}

method Failing(j: nat)
  requires j > 0 {
  assert j >= 1;
  assert j > 2;
}






