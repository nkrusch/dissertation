Lemma send_ambiguous (alloc1 : alloc):
  exists (alloc2: alloc),
  (* observed exchange is the same *)
  alloc1.(A) = alloc2.(A)
  /\ send alloc1.(B) = send alloc2.(B)
  /\ send alloc1.(C) = send alloc2.(C)
  (* but allocated numbers are different *)
  /\ ~[alloc1.(B)] ⤭ [alloc2.(B)].
  /\ ~[alloc1.(C)] ⤭ [alloc2.(C)].