lemmik(tiina, koer, pontu).
lemmik(tiina, kass, miisu).
lemmik(tiina, papagoi, kiki).
lemmik(tiina, rott, ruudi).
lemmik(piret, koer, muki).
lemmik(piret, kass, peedu).
lemmik(peeter, kass, ants).
lemmik(peeter, koer, reks).

piretilemmik(X,Y):-
    lemmik(piret,X,Y).

kassiomanikud(X):-
    lemmik(X,kass,_).

koeradenimed(X):-
    lemmik(_, koer, X).

papagoiomanikunimed(X):-
    lemmik(X, papagoi, _).

sober(ants, punane, _, _).
sober(juri, _, korvpall, _).
sober(mati, _, _, _).

tennismangija(X):-
  sober(X, sinine, _, kana),
  sober(X, _, jalgpall, koer),
  sober(X, roheline, _, kanarilind),

  sober(X, _, tennis, _).

lendab(part).
lendab(hani).
