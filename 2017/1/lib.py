#!/usr/local/bin/python3

from functools import reduce

class Solver:
    def solve(self, input: str):
        elements = list(zip(input[1:], input)) + [(input[0], input[-1:])]
        return reduce(lambda x, y: x + (int(y[0]) if y[0] == y[1] else 0), elements, 0)

    def solve_imperatively(self, input: str):
        last = input[-1:]
        result = 0

        for i in input:
            if i == last:
                result += int(i)

            last = i

        return result
