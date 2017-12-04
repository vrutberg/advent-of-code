#!/usr/local/bin/python3

from lib import *
import unittest

class SolverTests(unittest.TestCase):
    def test_numbers_per_face(self):
        self.assertEqual(Solver().numbers_per_face(0), 1)
        self.assertEqual(Solver().numbers_per_face(1), 3)
        self.assertEqual(Solver().numbers_per_face(2), 5)
        self.assertEqual(Solver().numbers_per_face(3), 7)
        self.assertEqual(Solver().numbers_per_face(4), 9)

    def test_find_corner(self):
        self.assertEqual(Solver().find_corner(17), ((2, 2), 4))
        self.assertEqual(Solver().find_corner(13), ((2, 2), 0))
        self.assertEqual(Solver().find_corner(30), ((2, 2), 17))
        self.assertEqual(Solver().find_corner(31), ((3, 3), 0))
        self.assertEqual(Solver().find_corner(55), ((3, 3), 24))

    def test_traverse(self):
        self.assertEqual(Solver().traverse((3, 3), 24), (4, 2))
        self.assertEqual(Solver().traverse((3, 3), 0), (3, 3))
        self.assertEqual(Solver().traverse((2, 2), 17), (3, 2))

if __name__ == '__main__':
    unittest.main()
