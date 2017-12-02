#!/usr/local/bin/python3

import itertools

class Solver:
    def solve(self, input: str):
        return sum([self.solve_row(row) for row in input])

    def solve_row(self, input: [int]):
        for number, otherNumber in filter(lambda x: x[0] != x[1], itertools.product(input, input)):
            division = int(number) / int(otherNumber)

            if division % 1 == 0:
                return int(division)
