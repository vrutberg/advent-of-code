#!/usr/local/bin/python3

from lib import *
import unittest

class SolverTests(unittest.TestCase):
    def test_example_one(self):
        self.assertEqual(Solver().solve("1122"), 3)

    def test_example_two(self):
        self.assertEqual(Solver().solve("1111"), 4)

    def test_example_three(self):
        self.assertEqual(Solver().solve("1234"), 0)

    def test_example_four(self):
        self.assertEqual(Solver().solve("91212129"), 9)

    def test_example_one(self):
        self.assertEqual(Solver().solve_imperatively("1122"), 3)

    def test_example_two(self):
        self.assertEqual(Solver().solve_imperatively("1111"), 4)

    def test_example_three(self):
        self.assertEqual(Solver().solve_imperatively("1234"), 0)

    def test_example_four(self):
        self.assertEqual(Solver().solve_imperatively("91212129"), 9)

if __name__ == '__main__':
    unittest.main()
