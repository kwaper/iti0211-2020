:- dynamic(ruut/3).

main(MyColor):-
    ruut(X,Y, MyColor),
    nl, write([MyColor, 'Nupp ', ruudul, X,Y]),
    leia_suund(MyColor,Suund),
    kaigu_variandid(X,Y,Suund,X1,Y1),
    !.
main(_).

leia_suund(1,1):- !.
leia_suund(2,-1).

%--------------------------------
kaigu_variandid(X,Y,Suund,X1,Y1):-
    votmine(X,Y,Suund,X1,Y1),!.
kaigu_variandid(X,Y,Suund,X1,Y1):-
    kaimine(X,Y,Suund,X1,Y1),!.
%--------------------------------
votmine(X,Y,Suund,X1,Y1):-
    kas_saab_votta(X,Y,Suund,X1,Y1,X2,Y2),

    vota(X,Y,Suund,X1,Y1,X2,Y2),
    fail.

vota(X,Y,Suund,X1,Y1,X2,Y2):-
    retract(ruut(X,Y,Varv)),
    assert(ruut(X,Y,0)),
    retract(ruut(X1,Y1,_)),
    assert(ruut(X1,Y1,0)),
    retract(ruut(X2,Y2,_)),
    assert(ruut(X2,Y2,Varv)).
%--------
kas_saab_votta(X,Y,Suund,X1,Y1,X2,Y2):-  % Votmine edasi paremale
    X1 is X + Suund,
    Y1 is Y + 1,
    ruut(X1,Y1, Color),
    Color =\= MyColor, Color =\= 0,
    X2 is X1 + Suund,
    Y2 is Y1 + 1,
    ruut(X2,Y2, 0).
kas_saab_votta(X,Y,Suund,X1,Y1,X2,Y2):-  % Votmine edasi vasakule
    X1 is X + Suund,
    Y1 is Y - 1,
    ruut(X1,Y1, Color),
    Color =\= MyColor, Color =\= 0,
    X2 is X1 + Suund,
    Y2 is Y1 - 1,
    ruut(X2,Y2, 0).
kas_saab_votta(X,Y,Suund,X1,Y1,X2,Y2):-  % Votmine tagasi paremale
    X1 is X + Suund * -1,
    Y1 is Y + 1,
    ruut(X1,Y1, Color),
    Color =\= MyColor, Color =\= 0,
    X2 is X1 + Suund * -1,
    Y2 is Y1 + 1,
    ruut(X2,Y2, 0).
kas_saab_votta(X,Y,Suund,X1,Y1,X2,Y2):-  % Votmine tagasi vasakule
    X1 is X + Suund * -1,
    Y1 is Y - 1,
    ruut(X1,Y1, Color),
    Color =\= MyColor, Color =\= 0,
    X2 is X1 + Suund * -1,
    Y2 is Y1 - 1,
    ruut(X2,Y2, 0).

%--------------------------------
kaimine(X,Y,Suund,X1,Y1):-
    kas_naaber_vaba(X,Y,Suund,X1,Y1),
    tee_kaik(X,Y,X1,Y1),
    write([' kaib ', X1,Y1]),
    fail.
kaimine(_,_,_,_,_).

tee_kaik(X,Y,X1,Y1):-
    retract(ruut(X,Y,Varv)),
    assert(ruut(X,Y,0)),
    retract(ruut(X1,Y1,_)),
    assert(ruut(X1,Y1,Varv)).

kas_naaber_vaba(X,Y,Suund,X1,Y1):-
    X1 is X +Suund,
    Y1 is Y + 1,
    ruut(X1,Y1, 0).
kas_naaber_vaba(X,Y,Suund,X1,Y1):-
    X1 is X +Suund,
    Y1 is Y -1,
    ruut(X1,Y1, 0), write(' voi ').

kas_naaber_vaba(X,Y,X1,Y1):-
    ruut(X,Y, Status),
    assert(ruut1(X1,Y1, Status)),!.

%---------MДNGU ALGSEIS-------------
% Valged
ruut(1,1,1).
ruut(1,3,1).
ruut(1,5,1).
ruut(1,7,1).
ruut(2,2,1).
ruut(2,4,1).
ruut(2,6,1).
ruut(2,8,1).
ruut(3,1,1).
ruut(3,3,1).
ruut(3,5,1).
ruut(3,7,1).
% Tьhjad ruudud
ruut(4,2,0).
ruut(4,4,0).
ruut(4,6,0).
ruut(4,8,0).
ruut(5,1,0).
ruut(5,3,0).
ruut(5,5,0).
ruut(5,7,0).
% Mustad
ruut(6,2,2).
ruut(6,4,2).
ruut(6,6,2).
ruut(6,8,2).
ruut(7,1,2).
ruut(7,3,2).
ruut(7,5,2).
ruut(7,7,2).
ruut(8,2,2).
ruut(8,4,2).
ruut(8,6,2).
ruut(8,8,2).

/*
ruut(X,Y, Status).  %   kus X, Y [1,8]
Status = 0      % tьhi
Status = 1      % valge
Status = 2      %  must
*/

%=================== Print checkers board - Start ==================
print_board :-
  print_squares(8).

print_squares(Row) :-
  between(1, 8, Row),
  write('|'), print_row_squares(Row, 1), write('|'), nl,
  NewRow is Row - 1,
  print_squares(NewRow), !.
print_squares(_) :- !.


print_row_squares(Row, Col) :-
  between(1, 8, Col),
  ruut(Col, Row, Status), write(' '), write(Status), write(' '),
  NewCol is Col + 1,
  print_row_squares(Row, NewCol), !.
print_row_squares(_, _) :- !.

%=================== Print checkers board - End ====================

%=================== Print checkers board v2 - Start ==================
status_sq(ROW,COL):-
  ( ruut(ROW,COL,COLOR),
    write(COLOR)
  );(
    write(' ')
  ).
status_row(ROW):-
  write('row # '),write(ROW), write('   '),
  status_sq(ROW,1),
  status_sq(ROW,2),
  status_sq(ROW,3),
  status_sq(ROW,4),
  status_sq(ROW,5),
  status_sq(ROW,6),
  status_sq(ROW,7),
  status_sq(ROW,8),
  nl.
% print the entire checkers board..
status:-
  nl,
  status_row(8),
  status_row(7),
  status_row(6),
  status_row(5),
  status_row(4),
  status_row(3),
  status_row(2),
  status_row(1).

%=================== Print checkers board v2 - End ====================
