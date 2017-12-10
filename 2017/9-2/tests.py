#!/usr/local/bin/python3

from solution import *
import unittest

class Tests(unittest.TestCase):
    def test_example_one(self):
        self.assertEqual(solve("<>"), 0)

    def test_example_two(self):
        self.assertEqual(solve("<random characters>"), 17)

    def test_example_three(self):
        self.assertEqual(solve("<<<<>"), 3)

    def test_example_four(self):
        self.assertEqual(solve("<{!>}>"), 2)

    def test_example_five(self):
        self.assertEqual(solve("<!!>"), 0)

    def test_example_six(self):
        self.assertEqual(solve("<!!!>>"), 0)

    def test_example_seven(self):
        self.assertEqual(solve('<{o"i!a,<{i<a>'), 10)

if __name__ == '__main__':
    unittest.main()
