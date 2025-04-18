Set Warnings "-redundant-canonical-projection,-notation-overridden".
Set Warnings "-extraction-opaque-accessed,-extraction".
From mathcomp Require Import all_ssreflect.
From Coq Require Import Extraction.

Set Implicit Arguments.
Unset Strict Implicit.
Unset Printing Implicit Defensive.


(** ** Exchange specification *) 
Section MessagingSpec.

  Implicit Types A : nat.
  Implicit Types B C t : nat * nat * nat.
  Implicit Types s : seq nat.

  Definition U := iota 1 7.  
  Definition L t := [:: t.1.1; t.1.2; t.2].
  Definition L3 n1 n2 n3 := L (n1, n2, n3).
  Definition T3 l := (nth 0 l 0, nth 0 l 1, nth 0 l 2).

  Class alloc : Type :=
    Alloc { A; B; C; req : perm_eq (A :: L B ++ L C) U; }.

  Definition alloc_lst a := a.(A) :: L B ++ L C.

  Definition outside s := [seq x <- U | x \notin s].

  Definition encode n1 n2 n3 x :=
    let r := (sumn (outside [:: n1; n2; n3]) + x) %% 7 in
    if r == 0 then 7 else r.

  Definition send t := encode t.1.1 t.1.2 t.2 7.
  Definition recv t m := encode t.1.1 t.1.2 t.2 m.
  Definition recover t n :=
    T3 [seq x <- outside (L t) | x != recv t n].

End MessagingSpec.  

Extraction "message.ml" send recv recover.
  
Notation "'Σ' n" :=
  (sumn n) (at level 50, left associativity).

Notation "A ⤭ B" :=
  (perm_eq A B) (at level 50, left associativity).

Notation "[ t ]" :=
  (L t) (at level 0, right associativity).

Notation "⃰ t" :=
  (alloc_lst t) (at level 0, right associativity).

Notation "n '.*3'" :=
  (n * 3) (at level 0, right associativity).

Notation "n '.-3'" :=
  (n - 3) (at level 0, right associativity).

Notation "X ≡% Y" :=
  ((Σ [X]) %% 7 = (Σ [Y]) %% 7)
  (at level 50, left associativity).

Definition BnC {a : alloc} x y :=
  (x = [B] /\ y = [C]) \/ (x = [C] /\ y = [B]).

Definition perm2 {T:eqType} x y (t : T * T * T) :=
  [::x; y] ⤭ [::t.1.1; t.1.2] \/
  [::x; y] ⤭ [::t.1.1; t.2] \/
  [::x; y] ⤭ [::t.1.2; t.2].

Definition min3 m n o := (minn m (minn n o)).*3.+3.
Definition max3 m n o := (maxn m (maxn n o)).*3.-3.


(** ** Example *)
Section ExampleExchange.

  (* Arbitrary allocation of numbers to people *)
  Let PA := 2.
  Let PB := (5, 1, 4).
  Let PC := (7, 3, 6).

  (* Allocation must be a permutation of the universe *)
  Instance M1 : alloc := {| req := isT: (PA :: [PB] ++ [PC]) ⤭ U |}.
  
  Let msg1 := send M1.(B). (* message sent from B to C *)
  Let msg2 := send M1.(C). (* message sent from C to B *)

  (* C knows A and B after receiving message from B *)
  Example C_knows_A : recv M1.(C) msg1 = PA. 
  Proof. by []. Qed.

  Example C_knows_B : [recover M1.(C) msg1] ⤭ [B].
  Proof. by []. Qed.

  (* B knows A and C after receiving message from C *)
  Example B_knows_A : recv M1.(B) msg2 = PA.
  Proof. by []. Qed.

  Example B_knows_C : [recover M1.(B) msg2] ⤭ [C].
  Proof. by []. Qed.
  
End ExampleExchange.


Section Basics.

  Variables (T: eqType).  
  Implicit Types (t : T * T * T).
  Implicit Types (w x y z : T) (s : seq T).
  Implicit Types (p : T -> bool) (pn: nat -> bool).

  Lemma sendE n : send n = encode n.1.1 n.1.2 n.2 7.
  Proof. by []. Qed.

  Lemma recvE m n : recv m n = encode m.1.1 m.1.2 m.2 n.
  Proof. by []. Qed.

  Lemma tmemE t : t = (t.1.1, t.1.2, t.2).
  Proof. by case: t; rewrite //= => t'; case: t'. Qed.

  Lemma mem1 m : m.1.1 \in [m].
  Proof. by exact: mem_head. Qed.

  Lemma mem2 m : m.1.2 \in [m].
  Proof. by rewrite mem_seq3 eq_refl !orbT. Qed.

  Lemma mem3 m : m.2 \in [m].
  Proof. by rewrite mem_seq3 eq_refl !orbT. Qed.

  Lemma cat3E a b c x y z :
    [:: a; b; c; x; y; z] = [:: a; b; c] ++ [:: x; y; z].
  Proof. by []. Qed.
  
  Lemma nmem_cat x s1 s2 :
    x \notin s1 ++ s2 = (x \notin s1) && (x \notin s2).
  Proof. by rewrite mem_cat negb_or. Qed.

  Lemma mem_xU s1 s2 :
    uniq (s1 ++ s2) -> forall x, x \in s2 -> x \notin s1.
  Proof. by rewrite cat_uniq=> /and3P[_ /hasPn H]???; apply: H. Qed.

  Lemma uniq_n3 x y z :
    uniq [:: x; y; z] = [&& x != y, x != z & y != z].
  Proof. by rewrite /= -cat1s nmem_cat !mem_seq1 andbT andbA. Qed.  

  Lemma eq_ifx x y : (if x == y then y else x) = x.
  Proof. by case H: (_ == _); symmetry; apply/eqP. Qed.

  Lemma modn_if b d m n :
    (if b then m else n) %% d = if b then m %% d else n %% d.
  Proof. by rewrite fun_if; case: b; rewrite -modn_mod. Qed.

  Lemma nmem3E w x y z :
    w \notin [:: x; y; z] = [&& w != x, w != y & w != z].
  Proof. by do 3! (rewrite -cat1s nmem_cat mem_seq1 ?andbT). Qed.
  
  Lemma perm_rot x s : perm_eql (x :: s) (s ++ [:: x]).
  Proof. by rewrite -cat1s; exact: perm_catC. Qed.

  Lemma mem_nhas s p : ~~ has p s -> [seq x <- s | p x] = [::].
  Proof. by rewrite has_filter; case: (filter _ _). Qed.

  Lemma has_nss s : ~~ has (fun a => a \notin s) s.
  Proof. by apply/hasP=> [[??]/negP ?]; congruence. Qed.
  
  Lemma filter_nseq s : [seq x <- s | x \notin s] = [::].
  Proof. by exact: (mem_nhas (has_nss s)). Qed.

  Lemma filter_useq s1 s2 :
    uniq (s1 ++ s2) -> [seq z <- s1 | z \notin s2] = s1.
  Proof.
    rewrite uniq_catC cat_uniq=> /and3P[???];
    by apply/all_filterP; rewrite all_predC.
  Qed.

  Lemma filter_neq1 x: [seq x' <- [:: x] | x' != x] = [::].
  Proof. by apply/mem_nhas/hasP=> [[x']]; rewrite mem_seq1 /negb=> ->. Qed.

  Lemma filter_nequ x s :
    uniq (x :: s) -> [seq x' <- s | x' != x] = s.
  Proof.
    rewrite cons_uniq=> /andP[H1 _]; apply/all_filterP/allP=> [y H2].
    case C: (y == x)=> //; move: C H2=> /eqP ->.
    move: H1; rewrite -has_pred1=> H1 H2; congruence.
  Qed.
  
  Lemma filter_sort_leq pn sn :
    [seq x <- sort leq sn | pn x] = sort leq [seq x <- sn | pn x].
  Proof.
    apply: filter_sort.
    - exact: Order.TotalTheory.le_total.
    - exact: Order.le_trans.
  Qed.

End Basics.


Section Numeric.

  Lemma mult_n3 (n : nat) : n.*3 = n + n + n.
  Proof. by rewrite !mulnSr muln0 add0n. Qed.

  Lemma add3_distl m n o : (m + n + o).+3 = m.+2 + n.+1 + o.
  Proof. by rewrite -addnS -!addSn -addSnnS -addnS. Qed.
  
  Lemma add3_distr m n o : (m + n + o).+3 = m + n.+1 + o.+2.
  Proof. by rewrite -addSn -!addnS. Qed.
  
  Section LtnH.
    
    Variables (m n o : nat).
    Hypothesis lt1 : m < n.
    Hypothesis lt2 : n < o.
  
    Lemma lt3_gt0 : m < n -> 0 < m + n + o.
    Proof. by case: m=> [?|??]; rewrite ltn_addr. Qed.

    Lemma ltn_mo : (m.+1 < o).
    Proof. by exact: (leq_ltn_trans lt1). Qed.

    Lemma ladd3n : m.*3.+3 <= m + n + o.
    Proof. by rewrite mult_n3 add3_distr !leq_add ?ltn_mo. Qed.
  
    Lemma lsub3n : m + n + o <= o.*3.-3.
    Proof.      
      rewrite (leq_psubRL _ _ (lt3_gt0 lt1)) add3n;
      by rewrite add3_distl mult_n3 !leq_add ?ltn_mo.
    Qed.
  
    Lemma lmin3 : minn m (minn n o) = m.
    Proof.
      rewrite minnC minnE subnA ?subnn // leq_min;
      by do 3? (rewrite ltnW // ?ltn_mo).
    Qed.

    Lemma lmax3 : maxn m (maxn n o) = o.
    Proof.
      rewrite maxnA maxnC; apply/maxn_idPl; rewrite geq_max;
      by do 2? (rewrite ltnW // ?ltn_mo).
    Qed.

    Lemma ltnt_mn_mx: min3 m n o <= m + n + o <= max3 m n o.
    Proof. by rewrite /min3/max3 lmin3 lmax3 ladd3n lsub3n. Qed.
    
  End LtnH.
  
  Lemma sumn_uniq3 m n o :
    uniq [:: m; n; o] ->
    min3 m n o <= Σ [:: m; n; o] <= max3 m n o.
  Proof.
    rewrite uniq_n3 !neq_ltn /= addn0 addnA;
    move=> /and3P[/orP[?|?]/orP[?|?]]=> [/orP[?|?]|_|_|/orP[?|?]];
    rewrite /min3 /max3; first by rewrite ltnt_mn_mx.
    - by rewrite [_ n _]minnC [_ n _]maxnC addnAC ltnt_mn_mx.
    - by rewrite [_ n _]minnC [_ n _]maxnC minnCA maxnCA
         addnCAC addnAC ltnt_mn_mx.
    - by rewrite minnCA maxnCA -addnA addnCA addnA ltnt_mn_mx.
    - by rewrite minnCA [_ m _]minnC maxnCA [_ m o]maxnC
         addnACl addnA ltnt_mn_mx.
    - by rewrite minnC minnAC minnC maxnC maxnAC maxnC addnCAC
         ltnt_mn_mx.
  Qed.

  Lemma inU_rangeE x :
    (1 <= x <= 7) =
    [|| x == 1, x == 2, x == 3, x == 4, x == 5, x == 6 | x == 7].
  Proof. do 8 (case: x=> // x). Qed.

  Lemma range_un3 t :
    (forall x, x \in [t] -> 1 <= x <= 7) ->
    uniq [t] -> 6 <= Σ [t] <= 18.
  Proof.
    move=> H /sumn_uniq3/andP[H1 H2]; apply/andP;
    move: (mem2 t) (mem1 t)=> /H/andP[N1 M1] /H/andP[N2 M2];
    move: (mem3 t)=> /H/andP[N3 M3]; split.
    - apply: leq_trans H1;
      by rewrite !ltnS leq_pmull // !leq_min N1 N2 N3.      
    - apply: (leq_trans H2); rewrite leq_subLR add3n;
      by rewrite -[21]/(7*3) leq_pmul2r // !geq_max M1 M2 M3.
  Qed.

  Lemma ttE (t1 t2: nat * nat * nat) :
    [|| t1.1.1 \in [t2], t1.1.2 \in [t2] | t1.2 \in [t2]]
    <-> exists n, n \in [t1] /\ n \in [t2].
  Proof.
    split=> [/or3P[] H|[x]]; [exists t1.1.1|exists t1.1.2|exists t1.2|];
    rewrite ?H ?mem_seq3 ?eq_refl ?orTb ?orbT //.
    by move=> [/or3P[] /eqP ->] ->; rewrite ?orbT ?orTb.
  Qed.
  
  Lemma sort_irrel s : Σ sort leq s = Σ s.
  Proof. by move: (perm_sort leq s)=> /permPl/perm_sumn. Qed.

  Lemma sum_seq1 n : Σ [:: n] = n.
  Proof. by rewrite /= addn0. Qed.

  Lemma T3_size sn: size sn = 3 -> [T3 sn] = sn.
  Proof. by do 4! (case: sn=> // ? sn). Qed.
  
End Numeric.


Section Permutations.
  
  Lemma perm_in {T:eqType} (s1 s2 : seq T) :
    s1 ⤭ s2 -> forall x, (x \in s1) = (x \in s2).
  Proof. by move=> /perm_mem H ?; rewrite H. Qed.
  
  Lemma perm_neq {T:eqType} (s1 s2 : seq T) :
    s1 ⤭ s2 -> forall x, (x \notin s1) = (x \notin s2).
  Proof. by move=> /perm_mem=> H ?; rewrite H. Qed.
  
  Lemma perm_outside s1 s2 :
    s1 ⤭ s2 -> outside s1 = outside s2.
  Proof. by rewrite /outside=> /perm_neq ?; apply: eq_filter. Qed.
  
  Lemma perm_cat_outl s1 s2 :
    s1 ⤭ s2 -> forall l, outside (l ++ s1) = outside (l ++ s2).
  Proof. by move=>>*; apply/perm_outside/perm_cat. Qed.

  Lemma perm_send t1 t2 : L t1 ⤭ L t2 -> send t1 = send t2.
  Proof. by rewrite !sendE /encode=> /perm_outside->. Qed.

  Lemma perm2_third x y t :
    perm2 x y t -> exists z, [:: x; y; z] ⤭ [t].
  Proof.
    move=> [|[|]]; rewrite perm_sym=> H; [exists t.2|exists t.1.2|exists t.1.1];
    rewrite 2! perm_rot ?perm_cons perm_sym //;
    by rewrite perm_rot ?perm_cons perm_rot // perm_cons.
  Qed.
  
  Lemma perm_subx t x b :
    uniq [t] -> perm2 x b t <-> x \in [t] /\ b \in [t] /\ x != b.     
  Proof.
    move=> HU; split=> [/perm2_third [z]|].
    - rewrite perm_sym=> H;
      rewrite 2! (perm_in H) !mem_seq3 !eq_refl orbT orTb;
      move: H; rewrite perm_sym=> /perm_uniq;
      by rewrite HU uniq_n3=> /and3P[->].
    - rewrite !mem_seq3; do 2! (move=> [/or3P[]]/eqP ->);
      rewrite /negb ?eq_refl //;
      [left|right;left|left|right;right|right;left|right;right];
      by rewrite // -cat1s perm_catC.
  Qed.

  Lemma encode_symmetric m1 m2 m3 n1 n2 n3 x :
    encode m1 m2 m3 (encode n1 n2 n3 x) =
    encode n1 n2 n3 (encode m1 m2 m3 x).
  Proof.
    rewrite /encode -modnDmr; symmetry; rewrite -modnDmr;
    by rewrite !modn_if !modnn !modn_mod !eq_ifx !modnDmr addnCA.
  Qed.

End Permutations.

Section SingleAllocation.

  Variables (a: alloc).

  (** ** Membership *)
  
  Lemma reqE : ⃰a ⤭ U.
  Proof. by exact: req. Qed.

  Lemma uniqU : uniq U.
  Proof. by []. Qed.

  Lemma uniq_alloc : uniq ⃰a.
  Proof. by apply: perm_uniq reqE. Qed.

  Lemma sortU : sort leq U = U.
  Proof. by []. Qed.    

  Lemma iotaUE : U = iota 1 7.
  Proof. by []. Qed.

  Lemma lbE : L B = [:: B.1.1; B.1.2; B.2].
  Proof. by []. Qed.
  
  Lemma lcE : L C = [:: C.1.1; C.1.2; C.2].
  Proof. by []. Qed.

  Lemma sortaU : U = sort leq ⃰a.
  Proof.
    move: reqE=> /perm_sortP -> //.
    - by exact: Order.TotalTheory.le_total.
    - by exact: Order.le_trans.
    - by exact: anti_leq.
  Qed.

  Lemma aE : ⃰a = A :: [B] ++ [C].
  Proof. by []. Qed.

  Lemma rot_alloc : ⃰a ⤭ U -> (A :: L C ++ L B) ⤭ U.
  Proof. by rewrite aE -cat1s catA perm_catAC. Qed.

  Lemma uniq_A : A \notin [B] ++ [C].
  Proof. by move: uniq_alloc; rewrite aE cons_uniq=> /andP[]. Qed.

  Lemma uniq_BC : uniq ([B] ++ [C]).
  Proof. by move: uniq_alloc; rewrite aE cons_uniq=> /andP[]. Qed.
  
  Lemma uniq_B : uniq [B].
  Proof. by move: uniq_BC; rewrite cat_uniq=> /and3P[]. Qed.
  
  Lemma uniq_C : uniq [C].
  Proof. by move: uniq_BC; rewrite cat_uniq=> /and3P[]. Qed.

  Lemma uniq_AB : A \notin [B].
  Proof. by move: uniq_A; rewrite nmem_cat=> /andP[]. Qed.

  Lemma uniq_AC : A \notin [C].
  Proof. by move: uniq_A; rewrite nmem_cat=> /andP[]. Qed.
  
  Lemma mem_allocU x : (x \in U) = (x \in ⃰a).
  Proof. by rewrite -!has_pred1 (perm_has _ reqE). Qed.

  Lemma mem_aU : A \in U.
  Proof. by rewrite mem_allocU mem_head. Qed.

  Lemma mem_bU x : x \in [B] -> x \in U.
  Proof. by rewrite mem_allocU aE -cat1s !mem_cat orbC=> ->. Qed.

  Lemma mem_cU x : x \in [C] -> x \in U.
  Proof. by rewrite mem_allocU aE -cat1s !mem_cat orbA orbC=> ->. Qed.

  Lemma mem_BnC x : x \in [B] -> x \notin [C].
  Proof. by apply: mem_xU; rewrite uniq_catC; exact: uniq_BC. Qed.

  Lemma mem_CnB x : x \in [C] -> x \notin [B].
  Proof. by exact: (mem_xU uniq_BC). Qed.
  
  Lemma filter_nBC X Y :
    BnC X Y -> [seq x <- ⃰a | x \notin X] = A :: Y.
  Proof.
    move=> [[-> ->]|[-> ->]]; rewrite aE -cat1s !filter_cat;
    rewrite filter_nseq !filter_useq ?uniq_BC //.
    - by rewrite uniq_catC uniq_BC.
    - by rewrite cons_uniq uniq_AB uniq_B.
    - by rewrite cons_uniq uniq_AC uniq_C.
  Qed.

  Lemma mem_nB : [seq x <- ⃰a | x \notin [B]] = A :: [C].
  Proof. by apply: filter_nBC; left. Qed.

  Lemma mem_nC : [seq x <- ⃰a | x \notin [C]] = A :: [B].
  Proof. by apply: filter_nBC; right. Qed.

  Lemma deduce_C X : [B] ⤭ X -> L C ⤭ outside (A :: X).
  Proof.
    rewrite -cat1s=> /perm_cat_outl <-; rewrite /outside/U -iotaUE.
    move: sortaU; rewrite aE -cat1s catA=> ->.
    rewrite filter_sort_leq filter_cat filter_nseq filter_useq.
    - by rewrite perm_sym perm_sort perm_refl.
    - by rewrite uniq_catC uniq_alloc.
  Qed.

  (** ** Numeric values *)

  Lemma sum_uE : Σ U = 28.
  Proof. by []. Qed.

  Lemma sumU_modn : (Σ U) %% 7 = 0.
  Proof. by []. Qed.
  
  Lemma sum_uaE : Σ U = Σ ⃰a.
  Proof. by apply: perm_sumn; rewrite  perm_sym reqE. Qed.

  Lemma sum_ABC : A + (Σ [B]) + (Σ [C]) = Σ U.
  Proof. by rewrite sum_uaE aE -cat1s !sumn_cat sum_seq1 addnA. Qed.

  Lemma sum3E t : Σ [t] = t.1.1 + t.1.2 + t.2.
  Proof. by rewrite /L/= addn0 addnA. Qed.

  Lemma inUE x : (x \in U) = (1 <= x <= 7).
  Proof. by rewrite iotaUE mem_iota. Qed.

  Lemma inUB x : x \in [B] -> 1 <= x <= 7.
  Proof. rewrite -inUE; exact: mem_bU. Qed.
  
  Lemma inUC x : x \in [C] -> 1 <= x <= 7.
  Proof. rewrite -inUE; exact: mem_cU. Qed.
  
  Lemma sum_BltU : Σ [B] <= Σ U.
  Proof. by exact: (leq_trans(proj2(andP(range_un3 inUB uniq_B)))). Qed.

  Lemma sum_CltU : Σ [C] <= Σ U.
  Proof. by exact: (leq_trans(proj2(andP(range_un3 inUC uniq_C)))). Qed.
  
  Lemma sum_Uxy X Y:
    BnC X Y -> Σ sort leq (A :: X) = Σ U - Σ Y.
  Proof.
    move=> [[-> ->]|[-> ->]]; symmetry;
    rewrite sum_uaE aE -cat1s !sumn_cat addnA -sumn_cat sort_irrel;    
    [|rewrite sumn_cat addnAC -sumn_cat cat1s];
    by rewrite -addnBA ?leqnn ?subnn ?addn0.
  Qed.
  
  Lemma sum_AB : Σ sort leq (A :: [B]) = Σ U - Σ [C].
  Proof. by apply: sum_Uxy; left. Qed.
  
  Lemma sum_AC : Σ sort leq (A :: [C]) = Σ U - Σ [B].
  Proof. by apply: sum_Uxy; right. Qed.                         
           
  Lemma alloc_permB :
    [|| [B] ⤭ L (1, 2, 3), [B] ⤭ L (1, 2, 4),
    [B] ⤭ L (1, 2, 5), [B] ⤭ L (1, 2, 6), [B] ⤭ L (1, 2, 7),
    [B] ⤭ L (1, 3, 4), [B] ⤭ L (1, 3, 5), [B] ⤭ L (1, 3, 6),
    [B] ⤭ L (1, 3, 7), [B] ⤭ L (1, 4, 5), [B] ⤭ L (1, 4, 6),
    [B] ⤭ L (1, 4, 7), [B] ⤭ L (1, 5, 6), [B] ⤭ L (1, 5, 7),
    [B] ⤭ L (1, 6, 7), [B] ⤭ L (2, 3, 4), [B] ⤭ L (2, 3, 5),
    [B] ⤭ L (2, 3, 6), [B] ⤭ L (2, 3, 7), [B] ⤭ L (2, 4, 5),
    [B] ⤭ L (2, 4, 6), [B] ⤭ L (2, 4, 7), [B] ⤭ L (2, 5, 6),
    [B] ⤭ L (2, 5, 7), [B] ⤭ L (2, 6, 7), [B] ⤭ L (3, 4, 5),
    [B] ⤭ L (3, 4, 6), [B] ⤭ L (3, 4, 7), [B] ⤭ L (3, 5, 6),
    [B] ⤭ L (3, 5, 7), [B] ⤭ L (3, 6, 7), [B] ⤭ L (4, 5, 6),
    [B] ⤭ L (4, 5, 7), [B] ⤭ L (4, 6, 7)| [B] ⤭ L (5, 6, 7)].
  Proof.
    move: uniq_B; rewrite lbE uniq_n3=> /and3P[H1 H2 H3];
    move: (mem_bU (mem1 B)) (mem_bU (mem2 B)) (mem_bU (mem3 B));
    rewrite !inUE !inU_rangeE;
    move=> /or4P[|||/or4P[|||]]=> /eqP Ha;
    move=> /or4P[|||/or4P[|||]]=> /eqP Hb;
    move: H1; rewrite Ha Hb // => _;
    move=> /or4P[|||/or4P[|||]]=> /eqP Hc;
    by move: H3 H2; rewrite Ha Hb Hc.
  Qed.
    
  Lemma alloc_subsum :
    Σ [B] != Σ [C] %[mod 7] -> exists (a b c d : nat),
    (a + b) = (c + d) %[mod 7] /\ perm2 a b B /\ perm2 c d C.
  Proof.    
    move: alloc_permB=>
          /or4P[|||/or4P[|||/or4P[|||/or4P[|||/or4P[|||
          /or4P[|||/or4P[|||/or4P[|||/or4P[|||/or4P[|||
          /or4P[|||/orP[|]]]]]]]]]]]] HB H;
    move: (perm_neq HB a.(A)); rewrite uniq_AB nmem3E/= => /eqP/and3P[];
    move: mem_aU; rewrite inUE inU_rangeE;
    move=> /or4P[|||/or4P[|||]]=> /eqP Ha; rewrite Ha // => _ _ _;
    move: (deduce_C HB); rewrite Ha /outside/= => HC;
    move: (perm_sumn HB) (perm_sumn HC) H=> -> ->; rewrite //= => _;
    [ exists 1, 3, 5, 6 | exists 1, 3, 4, 7 | exists 1, 3, 4, 7 | exists 1, 2, 4, 6
    | exists 1, 4, 5, 7 | exists 1, 2, 3, 7 | exists 1, 2, 3, 7 | exists 1, 5, 6, 7
    | exists 1, 5, 6, 7 | exists 1, 2, 3, 7 | exists 1, 2, 4, 6 | exists 1, 2, 3, 7 
    | exists 1, 2, 3, 7 | exists 1, 6, 3, 4 | exists 1, 2, 4, 6 | exists 1, 7, 3, 5 
    | exists 1, 2, 4, 6 | exists 1, 7, 3, 5 | exists 1, 3, 5, 6 | exists 1, 4, 5, 7 
    | exists 1, 3, 5, 6 | exists 1, 3, 4, 7 | exists 1, 5, 6, 7 | exists 1, 3, 4, 7 
    | exists 1, 5, 2, 4 | exists 1, 3, 4, 7 | exists 1, 6, 2, 5 | exists 1, 3, 4, 7 
    | exists 1, 6, 2, 5 | exists 1, 3, 5, 6 | exists 1, 3, 5, 6 | exists 1, 7, 2, 6 
    | exists 1, 5, 6, 7 | exists 1, 5, 6, 7 | exists 1, 4, 2, 3 | exists 1, 4, 2, 3 
    | exists 1, 4, 5, 7 | exists 1, 4, 5, 7 | exists 1, 4, 2, 3 | exists 1, 4, 2, 3 
    | exists 1, 7, 3, 5 | exists 1, 7, 2, 6 | exists 1, 4, 2, 3 | exists 1, 4, 2, 3
    | exists 1, 6, 3, 4 | exists 1, 5, 2, 4 | exists 1, 5, 2, 4 | exists 1, 5, 2, 4 
    | exists 1, 7, 2, 6 | exists 1, 5, 2, 4 | exists 1, 6, 3, 4 | exists 1, 6, 2, 5 
    | exists 1, 6, 2, 5 | exists 1, 6, 3, 4 | exists 2, 3, 5, 7 | exists 2, 4, 6, 7 
    | exists 2, 3, 5, 7 | exists 2, 4, 1, 5 | exists 3, 5, 1, 7 | exists 2, 3, 1, 4 
    | exists 2, 3, 1, 4 | exists 2, 3, 5, 7 | exists 2, 6, 1, 7 | exists 2, 3, 1, 4 
    | exists 2, 3, 1, 4 | exists 2, 7, 4, 5 | exists 2, 3, 1, 4 | exists 2, 3, 1, 4 
    | exists 2, 4, 6, 7 | exists 2, 5, 1, 6 | exists 2, 5, 1, 6 | exists 2, 6, 3, 5 
    | exists 2, 4, 1, 5 | exists 2, 6, 1, 7 | exists 2, 4, 1, 5 | exists 2, 7, 3, 6 
    | exists 2, 4, 1, 5 | exists 4, 7, 1, 3 | exists 4, 7, 1, 3 | exists 2, 5, 3, 4 
    | exists 2, 6, 1, 7 | exists 2, 6, 1, 7 | exists 5, 6, 1, 3 | exists 2, 5, 3, 4 
    | exists 5, 7, 1, 4 | exists 2, 5, 1, 6 | exists 5, 7, 1, 4 | exists 2, 6, 3, 5 
    | exists 6, 7, 1, 5 | exists 6, 7, 1, 5 | exists 3, 5, 2, 6 | exists 3, 4, 1, 6 
    | exists 3, 5, 1, 7 | exists 3, 4, 1, 6 | exists 3, 4, 2, 5 | exists 4, 6, 1, 2 
    | exists 4, 6, 1, 2 | exists 3, 4, 2, 5 | exists 3, 4, 1, 6 | exists 3, 7, 1, 2 
    | exists 3, 7, 1, 2 | exists 5, 6, 4, 7 | exists 3, 5, 1, 7 | exists 3, 5, 1, 7 
    | exists 3, 5, 2, 6 | exists 5, 7, 1, 4 | exists 3, 7, 1, 2 | exists 3, 7, 1, 2 
    | exists 6, 7, 2, 4 | exists 6, 7, 1, 5 | exists 3, 7, 1, 2 | exists 3, 7, 1, 2 
    | exists 4, 5, 2, 7 | exists 5, 6, 1, 3 | exists 4, 6, 1, 2 | exists 4, 6, 1, 2 
    | exists 5, 7, 2, 3 | exists 4, 7, 1, 3 | exists 4, 7, 1, 3 | exists 4, 7, 1, 3 
    | exists 4, 6, 1, 2 | exists 4, 6, 1, 2 | exists 5, 7, 2, 3 | exists 5, 6, 1, 3 
    | exists 5, 7, 1, 4 | exists 5, 6, 1, 3 ];
    by rewrite (perm_subx _ _ uniq_B) !(perm_in HB);
       rewrite (perm_subx _ _ uniq_C) !(perm_in HC).
  Qed.  
  
End SingleAllocation.


Section Allocations.

  Variables (A1 A2: alloc).

  Lemma alloc_permBC :
    A1.(A) = A2.(A) ->
    ([A1.(B)] ++ [A1.(C)]) ⤭ ([A2.(B)] ++ [A2.(C)]).
  Proof.
    rewrite -(perm_cons A1.(A)) -aE=> ->;
    by rewrite (perm_trans (reqE A1)) // perm_sym reqE. 
  Qed.

  Lemma alloc_modn_send x y :
    (x = A1.(B) /\ y = A2.(B)) \/ (x = A1.(C) /\ y = A2.(C)) ->
    x ≡% y -> send x = send y.
  Proof.
    move=> [[-> ->]|[-> ->]]=> H;
    rewrite !sendE/encode/outside/U -iotaUE;
    rewrite [U in LHS](sortaU A1) [U in RHS](sortaU A2);
    rewrite !filter_sort_leq ?mem_nB ?sum_AC ?mem_nC ?sum_AB;
    rewrite !modnDr !modnB ?sum_BltU ?sum_CltU;
    by move: H; rewrite // -modn_mod=> ->.
  Qed.
  
  Lemma alloc_sumB :
    A1.(B) ≡% A2.(B) -> send A1.(B) = send A2.(B).
  Proof. by apply: alloc_modn_send; left. Qed.

  Lemma alloc_sendC :
    A1.(A) = A2.(A) /\ A1.(B) ≡% A2.(B) ->
    send A1.(C) = send A2.(C).
  Proof.
    move=> [/alloc_permBC/perm_sumn H1 H2];
    apply: alloc_modn_send; [right=> //|];
    move: (f_equal2_nat _ modn _ _ _ _ H1 (eqP (eq_refl 7)));
    rewrite !sumn_cat -modnDm H2 modnDm=> [/eqP];
    by rewrite eqn_modDl=> /eqP H.
  Qed.

  Lemma send_condition : exists Ax,
    A1.(A) = Ax.(A) /\ A1.(B) ≡% Ax.(B) /\
    exists x, x \in [A1.(B)] /\ x \in [Ax.(C)].   
  Proof.    
    move: (leqVgt ((Σ [A1.(B)]) %% 7) ((Σ [A1.(C)]) %% 7));
    rewrite leq_eqVlt -orbA -neq_ltn;
    move=> /orP[/eqP H|/alloc_subsum [a [b [c [d]]]] [PermS]
         [/perm2_third [z PB] /perm2_third [e PC]]]. 
    - (* Σ B = Σ [C] *)      
      move: (rot_alloc (reqE A1))=> Ax; exists {| req := Ax |}.
      by rewrite -ttE H mem_head orTb.
    - (* Σ B != Σ [C] *)
      suff Ax: (A1.(A) :: [(c, d, z)] ++ [(a, b, e)]) ⤭ U.
      exists {| req := Ax |}; do 2! split=> //.
      + apply:eqP; rewrite -(perm_sumn PB) /= !addn0 !addnA;
        by rewrite -modnDml PermS modnDml eqn_modDl.
      + by exists a; rewrite -(perm_in PB) !mem_head.
      + apply: perm_trans (reqE A1);
        rewrite perm_cons lcE perm_rot /= perm_rot /=;
        by rewrite !cat3E perm_cat // perm_rot /= ?PB ?PC.
   Qed.
  
End Allocations.

Section MainTheorems.
  
  Variables (alloc1 : alloc).

  (* C (or B) learns everything from one message *)
  Lemma send_symmetric :
    recv C (send B) = recv B (send C).
  Proof. by rewrite recvE sendE encode_symmetric. Qed.
  
  Lemma send_reveals_A : recv C (send B) = A.
  Proof.
    rewrite recvE sendE /encode/outside sortaU;
    rewrite !filter_sort_leq mem_nB mem_nC !sort_irrel;
    do 2! (rewrite -cat1s sumn_cat sum_seq1);
    rewrite modnDr -modnDmr modn_if modn_mod eq_ifx modnDmr;
    rewrite addnCA sum_ABC sum_uE -modnDmr -[28 %% 7]/(0) addn0.
    move: (mem_aU alloc1); rewrite inUE inU_rangeE;
    by move =>/or4P[|||/or4P[|||]]=> /eqP ->.
  Qed.
  
  Lemma receiver_knows_sender S R :
    (S = B /\ R = C) \/ (S = C /\ R = B) ->
    [recover R (send S)] ⤭ [S].
  Proof.
    rewrite /recover; move=> [[-> ->]|[-> ->]];
    [|rewrite -send_symmetric]; rewrite send_reveals_A;
    rewrite /outside sortaU !filter_sort_leq ?mem_nB ?mem_nC;
    rewrite -cat1s filter_cat filter_neq1 filter_nequ 1? cons_uniq;
    [|rewrite uniq_AB uniq_B| |rewrite uniq_AC uniq_C]=> //; 
    by rewrite T3_size ?size_sort // perm_sort perm_refl.
  Qed.

  (* "A does not learn anything"
   * multiple allocations explain what A observes *)
  Lemma send_ambiguous : exists alloc2,
      alloc1.(A) = alloc2.(A)
      /\ send alloc1.(B) = send alloc2.(B)
      /\ send alloc1.(C) = send alloc2.(C)
      /\ ~ [alloc1.(B)] ⤭ [alloc2.(B)]
      /\ ~ [alloc1.(C)] ⤭ [alloc2.(C)].
  Proof.    
    move: (send_condition alloc1)=> [Ax [H1 [H2 [x [HA HB]]]]];
    exists Ax; do ? apply: conj=> //.
    - by apply: alloc_sumB.
    - by rewrite alloc_sendC // H1 H2.
    - move: (uniq_BC Ax); rewrite cat_uniq andbC
      => /and3P[/andP[/hasP/= H _] _] _
        /perm_in/(_ x) HC; apply: H;
      exists x; by rewrite -?HC.
    - move: (mem_BnC HA)=> HC;
      move=> /perm_neq/(_ x);
      by rewrite HB HC.
  Qed.

End MainTheorems.