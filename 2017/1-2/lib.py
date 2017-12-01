#!/usr/local/bin/python3

from functools import reduce

class Solver:
    def solve(self, input: str):
        result = 0
        length = len(input)

        for i in enumerate(input):
            if i[1] == input[(i[0] + length // 2) % length]:
                result += int(i[1])

        return result

    def solve_oneliner(self, input: str):
        length = len(input)

        return sum(int(c) for i, c in enumerate(input) if c == input[(i + length // 2) % length])
