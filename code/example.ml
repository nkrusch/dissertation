open Message

let rec to_int (n:nat) : int =
  match n with
  | O -> 0 
  | S n' -> 1 + to_int n'
;;

let n7 = S (S (S (S (S (S (S O))))))
let n6 = S (S (S (S (S (S O)))))
let n5 = S (S (S (S (S O))))
let n4 = S (S (S (S O)))
let n3 = S (S (S O)) 
let n2 = S (S O)
let n1 = S O

let pb = Pair (Pair (n5, n1), n4)
let pc = Pair (Pair (n7, n3), n6)

let ()=
  Printf.printf "B sends %i ==> C got A=%i and B=(%i, %i, %i)\n" 
  (to_int (send pb)) (to_int (recv pc (send pb))) 
  ((to_int (fst (fst pb)))) ((to_int (snd (fst pb)))) ((to_int (snd pb)))

let ()=
  Printf.printf "C sends %i ==> B got A=%i and C=(%i, %i, %i)\n" 
  (to_int (send pc)) (to_int (recv pb (send pc))) 
  ((to_int (fst (fst pc)))) ((to_int (snd (fst pc)))) ((to_int (snd pc)))
