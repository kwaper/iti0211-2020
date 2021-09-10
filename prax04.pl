laevaga(tallinn, helsinki, 120).
laevaga(tallinn, stockholm, 480).
laevaga(berlin, stockholm, 500).
bussiga(tallinn, riia, 300).
rongiga(riia, berlin, 680).
lennukiga(berlin, narva, 750).
lennukiga(tallinn, helsinki, 30).
lennukiga(helsinki, paris, 180).
lennukiga(paris, berlin, 120). 

reisi(S, F):-
    (   laevaga(S,F,_); bussiga(S,F,_); rongiga(S,F,_); lennukiga(S,F,_)).

reisi(S, F):-
    (   laevaga(S,X,_); bussiga(S,X,_); rongiga(S,X,_); lennukiga(S,X,_)),
    reisi(X,F).


reisi(S,F,mine(S,F)):-
    (   laevaga(S,F,_); bussiga(S,F,_); rongiga(S,F,_); lennukiga(S,F,_)).

reisi(S, F, mine(S, X, T)):-
    (   laevaga(S,X,_); bussiga(S,X,_); rongiga(S,X,_); lennukiga(S,X,_)),
    reisi(X, F, T).

reisi_transpordiga(S, F, mine(S,F,Tr)):-
    (   (   laevaga(S,F,_),Tr = laevaga);
    	(   bussiga(S,F,_), Tr = bussiga);
    	(   rongiga(S,F,_), Tr = rongiga);
    	(   lennukiga(S,F,_), Tr = lennukiga)).

reisi_transpordiga(S, F, mine(S,X,Tr,T)):-
    (   (   laevaga(S,X,_),Tr = laevaga);
    	(   bussiga(S,X,_), Tr = bussiga);
    	(   rongiga(S,X,_), Tr = rongiga);
    	(   lennukiga(S,X,_), Tr = lennukiga)),
    reisi_transpordiga(X,F,T).


reisi(S, F, mine(S,F,Tr),Hind):-
    (   (   laevaga(S,F,H1),Tr = laevaga);
    	(   bussiga(S,F,H1), Tr = bussiga);
    	(   rongiga(S,F,H1), Tr = rongiga);
    	(   lennukiga(S,F,H1), Tr = lennukiga)),
    Hind is H1.

reisi(S, F, mine(S,X,Tr,T),H1):-
    (   (   laevaga(S,X,H2),Tr = laevaga);
    	(   bussiga(S,X,H2), Tr = bussiga);
    	(   rongiga(S,X,H2), Tr = rongiga);
    	(   lennukiga(S,X,H2), Tr = lennukiga)),
	reisi(X,F,T, H3),
    H1 is H2 + H3.



