#!/usr/local/bin/python3

from solution import *
import unittest

class Tests(unittest.TestCase):
    def test_navigate_example_one(self):
        self.assertEqual(navigate(["ne","ne","ne"]), (3, 1))

    def test_navigate_example_two(self):
        self.assertEqual(navigate(["ne","ne","sw","sw"]), (0, 0))

    def test_navigate_example_three(self):
        self.assertEqual(navigate(["ne","ne","s","s"]), (2, -1))

    def test_navigate_example_four(self):
        self.assertEqual(navigate(["se","sw","se","sw","sw"]), (-1, -3))

    def test_navigate_se_se(self):
        self.assertEqual(navigate(["se","se"]), (2, -1))

    def test_calculate_direction_ne(self):
        self.assertEqual(calculate_direction((0, 0), (1, 0), False), 'ne')

    def test_calculate_direction_se(self):
        self.assertEqual(calculate_direction((0, 0), (1, 0), True), 'se')

    def test_calculate_direction_se_custom(self):
        self.assertEqual(calculate_direction((4, 2), (6, 1), False), 'se')

    def test_calculate_direction_nw(self):
        self.assertEqual(calculate_direction((0, 0), (-1, 0), False), 'nw')

    def test_calculate_direction_sw(self):
        self.assertEqual(calculate_direction((0, 0), (-1, 0), True), 'sw')

    def test_solve_example_one(self):
        self.assertEqual(solve(["ne","ne","ne"]), 3)

    def test_solve_example_one_south(self):
        self.assertEqual(solve(["s","s","s"]), 3)

    def test_solve_example_two(self):
        self.assertEqual(solve(["ne","ne","sw","sw"]), 0)

    def test_solve_example_three(self):
        self.assertEqual(solve(["ne","ne","s","s"]), 2)

    def test_solve_example_four(self):
        self.assertEqual(solve(["se","sw","se","sw","sw"]), 3)

    def test_solve_own_example(self):
        self.assertEqual(solve(["ne","ne","ne","ne","ne","ne","s","s"]), 6)

if __name__ == '__main__':
    unittest.main()
