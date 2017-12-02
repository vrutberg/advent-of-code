#!/usr/local/bin/python3

import sys

class Solver:
    def solve(self, input: str):
        return sum([self.solve_row(row) for row in input])

    def solve_row(self, input: [int]):
        min = sys.maxsize
        max = 0

        for number in input:
            if int(number) < min:
                min = int(number)

            if int(number) > max:
                max = int(number)

        return max - min
