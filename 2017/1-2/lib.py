#!/usr/local/bin/python3

from functools import reduce

class Solver:
    def solve(self, input: str):
        result = 0

        for i in enumerate(input):
            if i[1] == input[int((i[0] + len(input) / 2) % len(input))]:
                result += int(i[1])

        return result
