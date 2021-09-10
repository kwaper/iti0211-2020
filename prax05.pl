%laevaga(tallinn, helsinki, 1200, time(12, 45, 0.0), time(14, 45, 0.0)).
laevaga(tallinn, stockholm, 480, time(10, 0, 0.0), time(18, 30, 0.0)).
bussiga(tallinn, riia, 290,time(9, 10, 0.0), time(14, 30, 0.0)).
bussiga(helsinki, paris, 180, time(13, 30, 0.0), time(19, 30, 0.0)).
lennukiga(tallinn, helsinki, 10, time(10, 40, 0.0), time(11, 15, 0.0)).
rongiga(riia, berlin, 200, time(15, 0, 0.0), time(19, 30, 0.0)).
rongiga(paris, berlin, 120, time(20, 15, 0.0), time(22, 30, 0.0)).

:- dynamic(labitud/1).

odavaim_reis(S,F,Tee,Hind):-
    aggregate(min(Hind1, Tee1),reisi(S,F,Tee1,Hind1), min(Hind,Tee)).

reisi(S, F, mine(S,F,Tr),Hind1):-
    (   (   laevaga(S,F,H1,_,_),Tr = laevaga);
    	(   bussiga(S,F,H1,_,_), Tr = bussiga);
    	(   rongiga(S,F,H1,_,_), Tr = rongiga);
    	(   lennukiga(S,F,H1,_,_), Tr = lennukiga)),
    Hind1 is H1.


reisi(S, F, mine(S,X,Tr,T),Hind1):-
    (   (   laevaga(S,X,H2,_,_),Tr = laevaga);
    	(   bussiga(S,X,H2,_,_), Tr = bussiga);
    	(   rongiga(S,X,H2,_,_), Tr = rongiga);
    	(   lennukiga(S,X,H2,_,_), Tr = lennukiga)),
    not(labitud(X)), assertz(labitud(S)),
    reisi(X,F,T, H3),
    Hind1 is H2 + H3,
    retractall(labitud/1).




lyhim_reis(S,F,Tee,Hind):-
    aggregate_all(min(Aeg1,set(Tee1, Hind1)),reisi(S,F,Tee1,Hind1, Aeg1), min(Aeg1,set(Tee, Hind))).

reisi(S, F, mine(S,F,Tr),Hind1, Aeg):-
    (   (   laevaga(S,F,H1,Aeg1,Aeg2),Tr = laevaga);
    	(   bussiga(S,F,H1,Aeg1,Aeg2), Tr = bussiga);
    	(   rongiga(S,F,H1,Aeg1,Aeg2), Tr = rongiga);
    	(   lennukiga(S,F,H1,Aeg1,Aeg2), Tr = lennukiga)),
    Hind1 is H1,
    aegade_vahe(Aeg1,Aeg2, Vahe),
    Aeg is Vahe.

reisi(S, F, mine(S,X,Tr,T),Hind1, Aeg):-
    assertz(labitud(S)),
    (   (   laevaga(S,X,H2,Aeg1,Aeg2),Tr = laevaga);
    	(   bussiga(S,X,H2,Aeg1,Aeg2), Tr = bussiga);
    	(   rongiga(S,X,H2,Aeg1,Aeg2), Tr = rongiga);
    	(   lennukiga(S,X,H2,Aeg1,Aeg2), Tr = lennukiga)),
    not(labitud(X)),
    reisi(X,F,T, H3, Aeg3),
    Hind1 is H2 + H3,
    aegade_vahe(Aeg1, Aeg2,Vahe),
    Aeg is Vahe + Aeg3,
    %write(Aeg),
    retractall(labitud/1).


aegade_vahe(Aeg1, Aeg2, Vahe):-
	time(H1,M1,S1) = Aeg1,
	time(H2,M2,S2) = Aeg2,
    (   (   H2 < H1, H3 is ((H2 + 24) - H1) * 3600); (   H2 >= H1, H3 is (H2 - H1) * 3600)),
    (   (   M2 < M1, M3 is ((M2 + 60) - M1) * 60); (   M2 >= M1, M3 is (M2 - M1) * 60)),
    (   (   S2 < S1, S3 is (S2 + 60) - S1); (   S2 >= S1, S3 is S2 - S1)),
    Vahe is H3 + M3 + S3.

