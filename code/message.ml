
type __ = Obj.t
let __ = let rec f _ = Obj.repr f in Obj.repr f

type bool =
| True
| False

(** val negb : bool -> bool **)

let negb = function
| True -> False
| False -> True

type nat =
| O
| S of nat

type ('a, 'b) prod =
| Pair of 'a * 'b

(** val fst : ('a1, 'a2) prod -> 'a1 **)

let fst = function
| Pair (x, _) -> x

(** val snd : ('a1, 'a2) prod -> 'a2 **)

let snd = function
| Pair (_, y) -> y

type 'a list =
| Nil
| Cons of 'a * 'a list

(** val pred : nat -> nat **)

let pred n = match n with
| O -> n
| S u0 -> u0

(** val add : nat -> nat -> nat **)

let rec add n m =
  match n with
  | O -> m
  | S p -> S (add p m)

(** val sub : nat -> nat -> nat **)

let rec sub n m =
  match n with
  | O -> n
  | S k -> (match m with
            | O -> n
            | S l0 -> sub k l0)

type reflect =
| ReflectT
| ReflectF

(** val iffP : bool -> reflect -> reflect **)

let iffP _ pb =
  let _evar_0_ = fun _ _ _ -> ReflectT in
  let _evar_0_0 = fun _ _ _ -> ReflectF in
  (match pb with
   | ReflectT -> _evar_0_ __ __ __
   | ReflectF -> _evar_0_0 __ __ __)

(** val idP : bool -> reflect **)

let idP = function
| True -> ReflectT
| False -> ReflectF

type 't pred0 = 't -> bool

type 't predType =
  __ -> 't pred0
  (* singleton inductive, whose constructor was PredType *)

type 't pred_sort = __

type 't rel = 't -> 't pred0

type 't mem_pred =
  't pred0
  (* singleton inductive, whose constructor was Mem *)

(** val pred_of_mem : 'a1 mem_pred -> 'a1 pred_sort **)

let pred_of_mem mp =
  Obj.magic mp

(** val in_mem : 'a1 -> 'a1 mem_pred -> bool **)

let in_mem x mp =
  Obj.magic pred_of_mem mp x

(** val mem : 'a1 predType -> 'a1 pred_sort -> 'a1 mem_pred **)

let mem pT =
  pT

type 't eq_axiom = 't -> 't -> reflect

module Coq_hasDecEq =
 struct
  type 't axioms_ = { eq_op : 't rel; eqP : 't eq_axiom }

  (** val eq_op : 'a1 axioms_ -> 'a1 rel **)

  let eq_op record =
    record.eq_op
 end

module Equality =
 struct
  type 't axioms_ =
    't Coq_hasDecEq.axioms_
    (* singleton inductive, whose constructor was Class *)

  (** val eqtype_hasDecEq_mixin : 'a1 axioms_ -> 'a1 Coq_hasDecEq.axioms_ **)

  let eqtype_hasDecEq_mixin record =
    record

  type coq_type =
    __ axioms_
    (* singleton inductive, whose constructor was Pack *)

  type sort = __

  (** val coq_class : coq_type -> sort axioms_ **)

  let coq_class record =
    record
 end

(** val eq_op0 : Equality.coq_type -> Equality.sort rel **)

let eq_op0 s =
  (Equality.eqtype_hasDecEq_mixin (Equality.coq_class s)).Coq_hasDecEq.eq_op

(** val eqn : nat -> nat -> bool **)

let rec eqn m n =
  match m with
  | O -> (match n with
          | O -> True
          | S _ -> False)
  | S m' -> (match n with
             | O -> False
             | S n' -> eqn m' n')

(** val eqnP : nat eq_axiom **)

let eqnP n m =
  iffP (eqn n m) (idP (eqn n m))

(** val hB_unnamed_factory_1 : nat Coq_hasDecEq.axioms_ **)

let hB_unnamed_factory_1 =
  { Coq_hasDecEq.eq_op = eqn; Coq_hasDecEq.eqP = eqnP }

(** val datatypes_nat__canonical__eqtype_Equality : Equality.coq_type **)

let datatypes_nat__canonical__eqtype_Equality =
  Obj.magic hB_unnamed_factory_1

(** val addn_rec : nat -> nat -> nat **)

let addn_rec =
  add

(** val addn : nat -> nat -> nat **)

let addn =
  addn_rec

(** val subn_rec : nat -> nat -> nat **)

let subn_rec =
  sub

(** val subn : nat -> nat -> nat **)

let subn =
  subn_rec

(** val leq : nat -> nat -> bool **)

let leq m n =
  eq_op0 datatypes_nat__canonical__eqtype_Equality (Obj.magic subn m n)
    (Obj.magic O)

(** val nth : 'a1 -> 'a1 list -> nat -> 'a1 **)

let rec nth x0 s n =
  match s with
  | Nil -> x0
  | Cons (x, s') -> (match n with
                     | O -> x
                     | S n' -> nth x0 s' n')

(** val filter : 'a1 pred0 -> 'a1 list -> 'a1 list **)

let rec filter a = function
| Nil -> Nil
| Cons (x, s') ->
  (match a x with
   | True -> Cons (x, (filter a s'))
   | False -> filter a s')

(** val mem_seq :
    Equality.coq_type -> Equality.sort list -> Equality.sort -> bool **)

let rec mem_seq t = function
| Nil -> (fun _ -> False)
| Cons (y, s') ->
  let p = mem_seq t s' in
  (fun x -> match eq_op0 t x y with
            | True -> True
            | False -> p x)

type seq_eqclass = Equality.sort list

(** val pred_of_seq :
    Equality.coq_type -> seq_eqclass -> Equality.sort pred_sort **)

let pred_of_seq t s =
  Obj.magic mem_seq t s

(** val seq_predType : Equality.coq_type -> Equality.sort predType **)

let seq_predType t =
  Obj.magic pred_of_seq t

(** val iota : nat -> nat -> nat list **)

let rec iota m = function
| O -> Nil
| S n' -> Cons (m, (iota (S m) n'))

(** val foldr : ('a1 -> 'a2 -> 'a2) -> 'a2 -> 'a1 list -> 'a2 **)

let rec foldr f z0 = function
| Nil -> z0
| Cons (x, s') -> f x (foldr f z0 s')

(** val sumn : nat list -> nat **)

let sumn =
  foldr addn O

(** val modn_rec : nat -> nat -> nat **)

let rec modn_rec d m =
  match subn m d with
  | O -> m
  | S m' -> modn_rec d m'

(** val modn : nat -> nat -> nat **)

let modn m d =
  match leq (S O) d with
  | True -> modn_rec (pred d) m
  | False -> m

(** val u : nat list **)

let u =
  iota (S O) (S (S (S (S (S (S (S O)))))))

(** val l : ((nat, nat) prod, nat) prod -> nat list **)

let l t =
  Cons ((fst (fst t)), (Cons ((snd (fst t)), (Cons ((snd t), Nil)))))

(** val t3 : nat list -> ((nat, nat) prod, nat) prod **)

let t3 l0 =
  Pair ((Pair ((nth O l0 O), (nth O l0 (S O)))), (nth O l0 (S (S O))))

(** val outside : nat list -> Equality.sort list **)

let outside s =
  filter (fun x ->
    negb
      (in_mem x
        (mem (seq_predType datatypes_nat__canonical__eqtype_Equality)
          (Obj.magic s)))) (Obj.magic u)

(** val encode : nat -> nat -> nat -> nat -> nat **)

let encode n1 n2 n3 x =
  let r =
    modn
      (addn
        (sumn (Obj.magic outside (Cons (n1, (Cons (n2, (Cons (n3, Nil))))))))
        x) (S (S (S (S (S (S (S O)))))))
  in
  (match eq_op0 datatypes_nat__canonical__eqtype_Equality (Obj.magic r)
           (Obj.magic O) with
   | True -> S (S (S (S (S (S (S O))))))
   | False -> r)

(** val send : ((nat, nat) prod, nat) prod -> nat **)

let send t =
  encode (fst (fst t)) (snd (fst t)) (snd t) (S (S (S (S (S (S (S O)))))))

(** val recv : ((nat, nat) prod, nat) prod -> nat -> nat **)

let recv t m =
  encode (fst (fst t)) (snd (fst t)) (snd t) m

(** val recover :
    ((nat, nat) prod, nat) prod -> nat -> ((nat, nat) prod, nat) prod **)

let recover t n =
  t3
    (filter (fun x ->
      negb
        (eq_op0 datatypes_nat__canonical__eqtype_Equality (Obj.magic x)
          (Obj.magic recv t n))) (Obj.magic outside (l t)))
