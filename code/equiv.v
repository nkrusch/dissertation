Require Import Maps Imp.
From Coq Require Import Arith.PeanoNat. Import Nat.
From Coq Require Import Arith.EqNat.

Open Scope com_scope.

Definition aequiv (a1 a2 : aexp) : Prop :=
  forall (st : state),  aeval st a1 = aeval st a2.

Definition equiv (c1 c2 : com) : Prop :=
  forall (st st' : state), (st =[ c1 ]=> st') <-> (st =[ c2 ]=> st').

Notation "p '===' q" :=
  (cequiv p q) (at level 50, left associativity).

Theorem prog_eq b X Y Z :
    b = 0 \/ b = 1 ->
    <{ if b = 1 then Z := X else Z := Y end }>
    === <{ Z := X * b + Y * (1 - b) }>.
Proof.
  intros; split.
  (* if ... *)
  - intros C1; inversion C1; subst; clear C1;
      inversion H; subst; try discriminate;
      inversion H6; subst; apply E_Asgn; simpl;
      rewrite mul_0_r, mul_1_r; auto.
  (* Z := ... *)
  - intros C2; destruct H as [H|H]; subst;
      [apply E_IfFalse|apply E_IfTrue]; auto;
      inversion C2; subst; clear C2;
      apply E_Asgn; simpl;
      rewrite mul_0_r, mul_1_r; auto.
Qed.    
