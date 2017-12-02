#!/usr/local/bin/python3

from lib import *
import unittest

class SolverTests(unittest.TestCase):
    example = [[5, 1, 9, 5],
               [7, 5, 3],
               [2, 4, 6, 8]]

    def test_example_one(self):
        self.assertEqual(Solver().solve_row(self.example[0]), 8)

    def test_example_two(self):
        self.assertEqual(Solver().solve_row(self.example[1]), 4)

    def test_example_three(self):
        self.assertEqual(Solver().solve_row(self.example[2]), 6)

    def test_all(self):
        self.assertEqual(Solver().solve(self.example), 18)

if __name__ == '__main__':
    unittest.main()
