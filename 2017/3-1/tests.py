#!/usr/local/bin/python3

from lib import *
import unittest

class SolverTests(unittest.TestCase):
    def test_example_one(self):
        self.assertEqual(Solver().solve(1), 0)

    def test_example_two(self):
        self.assertEqual(Solver().solve(12), 3)

    def test_example_three(self):
        self.assertEqual(Solver().solve(23), 2)

    def test_example_four(self):
        self.assertEqual(Solver().solve(1024), 31)

if __name__ == '__main__':
    unittest.main()
