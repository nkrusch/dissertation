lemma Add0Left (n: nat)
  ensures 0 + n == n
{}

method Ok1(){
  assert 1 + 1 == 2;
}

method Failing1(i: nat){
  assert i > -1 ;
  var x := 1;
  assert x == 2;
}

method Failing2(j: nat)
  requires j > 0 {
  assert j >= 1;
  assert j > 2;
}

method Abs(x: int) returns (y: int)
  ensures 0 <= y
{
  if x < 0 {
    return -x;
  } else {
    return x;
  }
}

