viimane_element(X, [Y]):-
    X = Y.

viimane_element(X, [_|T]):-
    viimane_element(X, T).

suurim([H|[]], [H]).

suurim(List, _):-
    List = [].

suurim( [H1,H2|T] , X):-
    (   (H1 >= H2, X = [H1|X1]) ; ( H1 < H2, X = [H2|X1])	),
    suurim([H2|T],X1).

paki([H|[]], [H]).
 
paki( [ ] , [ ] ).
 
paki([H1,H2|T],X):-
    (   H1 \= H2, X = [H1|X1] ; X = X1),
    paki([H2|T], X1).

duplikeeri([H|[]], [H,H]).

duplikeeri([], _).

duplikeeri([H|T], X):-
    X = [H,H| X1],
    duplikeeri(T, X1).


kordista([], _, []).
 
kordista(List, N , X):-
    kordista(List, N, X, N).
 
kordista([H1|T],N, X, N1):-
    (   N1 > 0, X = [H1|X1], N2 is N1 - 1, kordista([H1|T], N, X1, N2));
    (   N1 == 0, kordista(T, N, X)).


paaris(N):-
    0 is N mod 2.

paaritu(N):-
    1 is N mod 2.
 
vordle_predikaadiga([], _, []).
 
vordle_predikaadiga([H|T], [H1|T1], X):-
    (   H1 == paaris_arv, paaris(H), X = [H|X1], vordle_predikaadiga(T, [H1|T1], X1));
    (   H1 == paaritu_arv, paaritu(H), X = [H|X1], vordle_predikaadiga(T, [H1|T1], X1));
    (   H1 == suurem_kui, H > T1, X = [H|X1], vordle_predikaadiga(T, [H1|T1], X1));
    vordle_predikaadiga(T, [H1|T1], X).

