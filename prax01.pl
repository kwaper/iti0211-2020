male(mina).
male(isa).
male(vanaisa1).
male(vanaisa2).
male(onu).

female(ode).
female(ema).
female(vanaema1).
female(vanaema2).
female(tadi).

married(ema,isa).
married(vanaema1,vanaisa1).
married(vanaema2,vanaisa2).

mother(mina, ema).
mother(ode, ema).
mother(isa,vanaema1).
mother(onu, vanaema1).
mother(ema, vanaema2).
mother(tadi, vanaema2).


father(Child, Father):-
    male(Father),
    married(Mother, Father),
    mother(Child, Mother).

brother(Child, Brother):-
    male(Brother),
    mother(Brother,Mother),
    mother(Child, Mother),
    Child \= Brother.

sister(Child, Sister):-
    female(Sister),
    mother(Sister,Mother),
    mother(Child, Mother),
    Child \= Sister.

aunt(Child, Aunt):-
    female(Aunt),
    (mother(Child, Mother),
    sister(Mother, Aunt);
    father(Child, Father),
    sister(Father, Aunt)).

uncle(Child, Uncle):-
    male(Uncle),
    (mother(Child, Mother),
    brother(Mother, Uncle);
    father(Child, Father),
    brother(Father, Uncle)).

grandfather(Child, Grandfather):-
    father(Child, Father),
    father(Father, Grandfather);
    mother(Child, Mother),
    father(Mother,Grandfather).

grandmother(Child, Grandmother):-
    father(Child, Father),
    mother(Father, Grandmother);
    mother(Child, Mother),
    mother(Mother,Grandmother).

