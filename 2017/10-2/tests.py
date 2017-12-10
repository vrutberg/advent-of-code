#!/usr/local/bin/python3

from solution import *
import unittest

class Tests(unittest.TestCase):
    def test_calculate_input(self):
        self.assertEqual(calculate_input("1,2,3"), [49,44,50,44,51,17,31,73,47,23])

if __name__ == '__main__':
    unittest.main()
