deletek([], _, _).

deletek([H], _ , [H]).

deletek([H|T], N, L2):-
    N \= 0,
    L2 = [H|T1],
    N1 is N - 1,
    deletek(T, N1, T1).

deletek([_|T], N , L2):-
    N = 0,
    N1 is N-1,
    deletek(T, N1, L2).



replace_el([], _, _, _).

    
replace_el([H], _, _, [H]).


replace_el([H|T], El1, El2, L2):-
    (   H = El1,
    	L2 = [El2 | T2],
        replace_el(T, El1, El2, T2))
    ;   
    (   H \= El1,
        L2 = [H | T2],
        replace_el(T,El1,El2, T2)).