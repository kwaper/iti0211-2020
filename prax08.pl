auto(bfm111, 2013, mercedes, silver, mikk).
auto(e00hgf, 1999, bmw, grey, toomas).
auto(l7rg5k, 2015, cadillac, black, niko).
auto(at052p, 2001, toyota, red, steven).
auto(s3g0p4, 2010, mercedes, yellow, peter).
auto(mesa39, 2019, bmw, green, karl).
auto(x78vee, 2004, porsche, purple, tiimo).
auto(avg32h, 2016, lamborgini, black, tavo).
auto(ddi57b, 2005, kia, green, karlos).
auto(e053ul, 2007, opel, silver, sven).

:- dynamic(uus/5). % 0 - 3
:- dynamic(suht_uus/5). % 4 - 5
:- dynamic(kasutatud/5). % 6 - 8
:- dynamic(vana/5). % 9 - 15
:- dynamic(romu/5). % 16 - 20
:- dynamic(uunikum/5). % > 20

:- dynamic(checked_auto/1).

group_cars():-
    auto(Number, Year, Mark, Color, Owner),
    not(checked_auto(Number)),
    Year_dif is 2020 - Year,
    (
    (Year_dif >= 0, Year_dif =< 3, assertz(uus(Number, Year, Mark, Color, Owner)));
    (Year_dif >= 4, Year_dif =< 5, assertz(suht_uus(Number, Year, Mark, Color, Owner)));
    (Year_dif >= 6, Year_dif =< 8, assertz(kasutatud(Number, Year, Mark, Color, Owner)));
    (Year_dif >=9, Year_dif =< 15, assertz(vana(Number, Year, Mark, Color, Owner)));
    (Year_dif >= 16, Year_dif =< 20, assertz(romu(Number, Year, Mark, Color, Owner)));
    (Year_dif > 20, assertz(uunikum(Number, Year, Mark, Color, Owner)))
    ),
    assertz(checked_auto(Number)),
    group_cars().

get_grouped(Uus, Suht_uus, Kasutatud, Vana, Romu, Uunikum):-
    findall((X,Y), uus(X,Y,_,_,_), Uus),
    findall((X,Y), suht_uus(X,Y,_,_,_), Suht_uus),
    findall((X,Y), kasutatud(X,Y,_,_,_), Kasutatud),
    findall((X,Y), vana(X,Y,_,_,_), Vana),
    findall((X,Y), romu(X,Y,_,_,_), Romu),
    findall((X,Y), uunikum(X,Y,_,_,_), Uunikum).


