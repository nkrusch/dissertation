(* In Rocq: From Stdlib Require ... *)
From Coq Require Import Arith List. Import Nat.

Parameter char : Set.
Implicit Type (s xs ys: list char).

Definition allEqual xs y := forall x, In x xs -> x = y.
Definition cutn n xs := (firstn n xs, skipn n xs).

Lemma cutn_app n: forall xs ys,
  n = length xs -> cutn n (xs ++ ys) = (xs, ys).
Proof.
 induction n; destruct xs; simpl; try easy.
 intros; unfold cutn in *; simpl.
 lapply (IHn xs ys); auto; congruence.
Qed.

Lemma minus_plus_max m n: m - n + n = max m n.
Proof.  
  intros; destruct (le_lt_dec m n).   
  - rewrite max_r; auto.
    replace (_ - _) with 0; auto.
    rewrite <-sub_0_le in *; auto.
  - rewrite max_l, sub_add; auto;
    erewrite lt_le_incl; auto.
Qed.

Definition leftpad c n s :=
  repeat c (n - length s) ++ s.

Theorem leftpad_correctness c n s :
  length (leftpad c n s) = max n (length s) /\
    exists m, let (prefix, suffix) := cutn m (leftpad c n s)
      in allEqual prefix c /\ suffix = s.
Proof.
 unfold leftpad, allEqual. split.
 - rewrite length_app, repeat_length; apply minus_plus_max.
 - exists (n-length s); rewrite cutn_app.
   + apply conj; auto; apply repeat_spec.
   + erewrite repeat_length; auto.
Qed.
