is_a(roovloomad,elusolend).
is_a(mitte-roovloomad,elusolend).
is_a(veeimetajad,roovloomad).
is_a(kalad,roovloomad).
is_a(saarmas,veeimetajad).
is_a(kobras,veeimetajad).
is_a(ahven,kalad).
is_a(haug,kalad).
is_a(zooplankton,mitte-roovloomad).
is_a(veetaimed,mitte-roovloomad).
is_a(vesikatk,veetaimed).
is_a(vetikas,veetaimed).
 
eats(zooplankton,veetaimed).
eats(kalad,zooplankton).
eats(veeimetajad,kalad).
 
:- dynamic(terminals/1).
 
count_terminals(Node, T, C):-
    findall(X, find_last(Node, X), T),
    count(L, T),
    C is L.

find_last(Node, X):-
    (   is_a(Node1, Node), find_last(Node1, X));
    (   not(is_a(_, Node)), X = Node, assertz(terminals(Node))).

count(0, []).

count(N, [_ | T]):-
    count(N1, T),
    N is N1 + 1.
 

extinction(Who, What_spieces, How_many):-
    who_die(_, Who),
    count_terminals(Who, _, _),
    setof(X, terminals(X), What_spieces),	
    count(L, What_spieces),
    How_many is L,
    retractall(terminals(_)).

who_die(Who, Node):-
	(   eats(Who, Node), count_terminals(Who, _, _), who_die(_, Who));
    (   not(eats(Who, Node))).
    


find_most_sensitive_species(Node, Count, Terminals):-
    aggregate_all(max(Hm, set(W, Ws)), extinction(W, Ws, Hm), max(Count, set(Node, Terminals))).

















 
 