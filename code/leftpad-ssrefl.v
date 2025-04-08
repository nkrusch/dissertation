From mathcomp Require Import ssreflect ssrbool ssrnat seq.

Section LeftPad.
  Variables (T : Type) (def : T).  
  Implicit Types (c : T) (n : nat) (s : seq T).
  Local Notation nth := (nth def).  (* nth list element *)

  Definition leftpad c n s : seq T :=
      ncons (n - size s) c s.

  Lemma length_max_spec c n s :
    size (leftpad c n s) = maxn n (size s).
  Proof. by rewrite size_ncons addnC maxnC maxnE. Qed.

  Lemma prefix_spec c n s : forall i,
    i < n - size s -> nth (leftpad c n s) i = c.
  Proof. by move=> i; rewrite nth_ncons => -> . Qed.

  Lemma suffix_spec c n s : forall i,
      i < size s ->
      nth (leftpad c n s) (n - size s + i) = nth s i.
  Proof.
    by move=> i _; rewrite nth_ncons addKn ifN//-ltnNge leq_addr.
  Qed.
End LeftPad.
