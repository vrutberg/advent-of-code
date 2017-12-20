#!/usr/local/bin/python3

from solution import *
import unittest

class Tests(unittest.TestCase):
    def test_example_one(self):
        self.assertEqual(solve([[0, 3], [1, 2], [4, 4], [6, 4]]), 24)

if __name__ == '__main__':
    unittest.main()
