function Max(a: int, b: int): int {
  if a > b then a else b
}

method LeftPad(c: char, n: int, s: seq<char>)
  returns (v: seq<char>)
  ensures |v| == Max(n, |s|) 
  ensures forall i :: 0 <= i < n - |s| ==> v[i] == c  
  ensures forall i :: 0 <= i < |s| ==> v[Max(n - |s|, 0) + i] == s[i] 
{
  var pad, i := Max(n - |s|, 0), 0;
  v := s;
  while i < pad
    invariant 0 <= i <= pad
    invariant |v| == |s| + i
    invariant forall j :: 0 <= j < i ==> v[j] == c
    invariant forall j :: 0 <= j < |s| ==> v[i + j] == s[j]
    decreases pad - i
  {
    v := [c] + v;
    i := i + 1;
  }
}