positions(0, []).
positions(X, [X | YS]) :- X >= 0, Y is X - 1, positions(Y, YS).

select([X | XS], X, XS).
select([C | XS], X, [C | YS]) :- select(XS, X, YS).

permutate([], []).
permutate(XS, [Y | YS]) :- select(XS, Y, XSS), permutate(XSS, YS).

len([], 0).
len([_ | XS], Y) :- len(XS, L), Y is L + 1.

notCollideOne(_, _, _, []).
notCollideOne(R1, C1, R2, [C2 | CS]) :-
    R2 - R1 =\= C2 - C1,
    R2 - R1 =\= C1 - C2,
    RN is R2 + 1, notCollideOne(R1, C1, RN, CS).

notCollide([], _).
notCollide([C | XS], R) :- 
    RN is R + 1,
    notCollideOne(R, C, RN, XS), 
    notCollide(XS, RN).

notCollide(L) :- notCollide(L, 1).

queens(L) :- 
    len(L, Len), 
    positions(Len, LS), 
    permutate(LS, L), 
    notCollide(L).