#!/usr/local/bin/python3

import sys

class Solver:
    def solve(self, input: str):
        return sum([self.solve_row(row) for row in input])

    def solve_row(self, input: [int]):
        for index, number in enumerate(input):
            for otherIndex, otherNumber in enumerate(input):
                if index == otherIndex:
                    continue

                division = int(number) / int(otherNumber)

                if division % 1 == 0:
                    return division
