pos(1).
pos(2).
pos(3).
pos(4).
pos(5).
pos(6).
pos(7).
pos(8).

allPos([]).
allPos([X | XS]) :- pos(X), allPos(XS).

oneAllDiff(_, []).
oneAllDiff(X, [Y | YS]) :- X =\= Y, oneAllDiff(X, YS).

allDiff([]).
allDiff([X | XS]) :- oneAllDiff(X, XS), allDiff(XS).

oneCheckDiag1(_, _, _, []).
oneCheckDiag1(R1, C1, R2, [C2 | CS]) :-
    R1 + C2 =\= R2 + C1,
    RN is R2 + 1,
    oneCheckDiag1(R1, C1, RN, CS).

checkDiag1(_, []).
checkDiag1(R, [C | CS]) :- RN is R + 1, oneCheckDiag1(R, C, RN, CS), checkDiag1(RN, CS).

oneCheckDiag2(_, _, _, []).
oneCheckDiag2(R1, C1, R2, [C2 | CS]) :-
    R1 + C1 =\= R2 + C2,
    RN is R2 + 1,
    oneCheckDiag2(R1, C1, RN, CS).

checkDiag2(_, []).
checkDiag2(R, [C | CS]) :- RN is R + 1, oneCheckDiag2(R, C, RN, CS), checkDiag2(RN, CS).

queens(A, B, C, D, E, F, G, H) :- 
    L = [A, B, C, D, E, F, G, H],
    allPos(L),
    allDiff(L),
    checkDiag1(1, L),
    checkDiag2(1, L).