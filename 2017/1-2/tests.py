#!/usr/local/bin/python3

from lib import *
import unittest

class SolverTests(unittest.TestCase):
    def test_example_one(self):
        self.assertEqual(Solver().solve("1212"), 6)

    def test_example_two(self):
        self.assertEqual(Solver().solve("1221"), 0)

    def test_example_three(self):
        self.assertEqual(Solver().solve("123425"), 4)

    def test_example_four(self):
        self.assertEqual(Solver().solve("123123"), 12)

    def test_example_five(self):
        self.assertEqual(Solver().solve("12131415"), 4)

    def test_example_one_oneliner(self):
        self.assertEqual(Solver().solve_oneliner("1212"), 6)

    def test_example_two_oneliner(self):
        self.assertEqual(Solver().solve_oneliner("1221"), 0)

    def test_example_three_oneliner(self):
        self.assertEqual(Solver().solve_oneliner("123425"), 4)

    def test_example_four_oneliner(self):
        self.assertEqual(Solver().solve_oneliner("123123"), 12)

    def test_example_five_oneliner(self):
        self.assertEqual(Solver().solve_oneliner("12131415"), 4)

if __name__ == '__main__':
    unittest.main()
