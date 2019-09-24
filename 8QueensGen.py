#! /usr/bin/python3

from itertools import combinations
from sys import argv

def linearize(x, ls):
    def go(x, it):
        if x > 0:
            g = []
            for _ in range(x):
                g.append(next(it))
            yield g

            yield from go(x - 1, it)

    return go(x, iter(ls))

if len(argv) > 1:
    try:
        x = int(argv[1])
        ran = range(1, x + 1)
        l = list('Q{}'.format(i) for i in ran)

        posDecl = '\n'.join('pos({}).'.format(i) for i in ran)
        isPosition = ', '.join(map('pos({})'.format, l))
        notEq = ',\n    '.join(
            ', '.join(g) for g in linearize(
                x - 1, 
                ('{} =\\= {}'.format(x, y) for x, y in combinations(l, 2))
            )
        )

        diag1 = ',\n    '.join(
            ', '.join(g) for g in linearize(
                x - 1, 
                ('{0} + Q{0} =\\= {1} + Q{1}'.format(x, y) for x, y in combinations(ran, 2))
            )
        )

        diag2 = ',\n    '.join(
            ', '.join(g) for g in linearize(
                x - 1, 
                ('{0} + Q{1} =\\= {1} + Q{0}'.format(x, y) for x, y in combinations(ran, 2))
            )
        )

        s = """{0}

queens({1}) :-
    {2},
    {3},

    {4},

    {5}.

queens([{1}]) :- queens({1})."""

        print(s.format(posDecl, ', '.join(l), isPosition, notEq, diag1, diag2, end=''))
    except ValueError:
        print('The argument is not a number.')