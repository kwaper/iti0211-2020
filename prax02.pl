male(mina).
male(isa).
male(vanaisa1).
male(vanaisa2).
male(vanaisa3).
male(onu).
female(ode).
female(ema).
female(vanaema1).
female(vanaema2).
female(vanaema3).
female(tadi).

married(ema,isa).
married(vanaema1,vanaisa1).
married(vanaema2,vanaisa2).
married(vanaema3,vanaisa3).

mother(mina, ema).
mother(ode, ema).
mother(isa,vanaema1).
mother(onu, vanaema1).
mother(ema, vanaema2).
mother(tadi, vanaema2).
mother(vanaisa1, vanaema3).
mother(vanaema2, vanaema3).


father(Child, Father):-
    male(Father),
    married(Mother, Father),
    mother(Child, Mother).


ancestor(C, G) :- 
    mother(C, G);
    father(C,G).

ancestor(C, G) :-
    (mother(C, Mother),
    ancestor(Mother, G));
    (father(C, Father),
    ancestor(Father, G)).


male_ancestor(C, G) :- 
    father(C,G).

male_ancestor(C, G) :-
    (   father(C, Isa),
    male_ancestor(Isa, G));
    (   mother(C, Ema),
    male_ancestor(Ema, G)).

female_ancestor(C, G) :- 
    mother(C,G).

female_ancestor(C, G) :-
    (   father(C, Isa),
    female_ancestor(Isa, G));
    (   mother(C, Ema),
    female_ancestor(Ema, G)).

ancestor1(C, G, N) :-
    N = 1,
    (   mother(C, G);
    father(C,G)).

ancestor1(C, G, N) :-
    (mother(C, Mother),
    N1 is N-1,
    ancestor1(Mother, G, N1));
    (father(C, Father),
    N1 is N-1,
    ancestor1(Father, G, N1)).


ancestor2(C):-
	(   male(C);female(C)).
    

ancestor2(C, G, N):-
    (   N = 0, ancestor2(C));
    (   N > 0,
        (   mother(C,G);father(C,G)),
        X is N-1,
        ancestor2(C,G,X));
    (   father(C,P);mother(C,P)),
    ancestor2(P,G,N).