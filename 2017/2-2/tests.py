#!/usr/local/bin/python3

from lib import *
import unittest

class SolverTests(unittest.TestCase):
    example = [[5, 9, 2, 8],
               [9, 4, 7, 3],
               [3, 8, 6, 5]]

    def test_example_one(self):
        self.assertEqual(Solver().solve_row(self.example[0]), 4)

    def test_example_two(self):
        self.assertEqual(Solver().solve_row(self.example[1]), 3)

    def test_example_three(self):
        self.assertEqual(Solver().solve_row(self.example[2]), 2)

    def test_all(self):
        self.assertEqual(Solver().solve(self.example), 9)

if __name__ == '__main__':
    unittest.main()
