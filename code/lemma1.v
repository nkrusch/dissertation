(* symbol $\times$ is a permutation *)
Lemma receiver_knows_sender S R :
  (S = B /\ R = C) \/ (S = C /\ R = B)
  -> [recover R (send S)] $\times$ [S].