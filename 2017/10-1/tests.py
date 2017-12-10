#!/usr/local/bin/python3

from solution import *
import unittest

class Tests(unittest.TestCase):
    # def test_example(self):
    #     self.assertEqual(solve(5, [3, 4, 1, 5]), 12)

    def test_another_example(self):
        self.assertEqual(solve(255, [70, 66]), 69*68)

if __name__ == '__main__':
    unittest.main()
