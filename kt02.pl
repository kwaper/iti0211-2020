%1 ulesanne

lause --> lihtlause.
lause --> liitlause.

liitlause --> lihtlause, sidesona, sidesona, lihtlause.

lihtlause --> nimisonafraas, tegusonafraas.
lihtlause --> nimisonafraas, tegusonafraas, nimisonafraas.

nimisonafraas --> nimisona.
nimisonafraas --> omadussona, omadussona, omadussona, nimisona.
nimisonafraas --> omadussona, nimisona.

tegusonafraas --> tegusona.

nimisona --> [mees] ; [kive].
tegusona --> [kannab] ; [ütleb].
omadussona --> [noor] ; [tubli] ; [osav].
sidesona --> [','] ; [et].


%“noor tubli osav mees kannab kive”
%”mees ütleb, et noor mees kannab kive”
%phrase(lause, [noor, tubli, osav, mees, kannab, kive]).
%phrase(lause, [mees, ütleb,,, et, noor, mees, kannab, kive]).



%2 ulesanne

yhisosa([], _, []).

yhisosa([H|T],H1,[H|T2]):-
    member(H, H1),
    yhisosa(T,H1,T2).

yhisosa([_|T],H1,H2):-
    yhisosa(T,H1,H2).

%yhisosa([1,2,a,3], [5,d,a,1], H3).


%3 ulesanne

h(h,1).
h(h,2).
h(h,3).
h(h,4).

:- dynamic(pair/2).

generate_pairs :-
    findall(X, h(_,X), Numbers),
    write(Numbers),
    generate_pairs(Numbers, Numbers, Numbers).

generate_pairs([H|T], [H1|T1], Numbers):-
    H1 > H,
    assertz(pair(H,H1)),
    generate_pairs([H|T], T1, Numbers).

generate_pairs([H|T], [H1|T1], Numbers):-
    H1 =< H,
    generate_pairs([H|T], T1, Numbers).

generate_pairs([_|T], [], [_| T1]):-
    generate_pairs(T, T1, T1).

generate_pairs([], [], _).



%4 ulesanne

list_partition([], _, [[]]).

list_partition([Eraldaja | ListIn], Eraldaja, [ [] | ListOut]):-
    list_partition(ListIn, Eraldaja, ListOut).

list_partition([H | ListIn], Eraldaja, [ [H | T1] | ListOut]):-
    list_partition(ListIn, Eraldaja, [T1 | ListOut]).

%list_partition([a,d,'R' ,' ' ,f,' ','While'], ' ', Out).





