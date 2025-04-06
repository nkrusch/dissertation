type bit = i: nat | i <= 1 witness 1

function Program2 (b : bit, X : nat, Y : nat) : nat {
  X * b + Y * (1 - b)
}

method Program1 (b : bit, X : nat, Y : nat) returns (Z: nat)
  ensures Z == Program2(b, X, Y) {
  if b == 1 { Z := X; }
  else { Z := Y; }
}
