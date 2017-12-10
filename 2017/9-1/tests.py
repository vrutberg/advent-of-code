#!/usr/local/bin/python3

from solution import *
import unittest

class Tests(unittest.TestCase):
    def test_example_one(self):
        self.assertEqual(solve("{}"), 1)

    def test_example_two(self):
        self.assertEqual(solve("{{{}}}"), 6)

    def test_example_three(self):
        self.assertEqual(solve("{{},{}}"), 5)

    def test_example_four(self):
        self.assertEqual(solve("{{{},{},{{}}}}"), 16)

    def test_example_five(self):
        self.assertEqual(solve("{<a>,<a>,<a>,<a>}"), 1)

    def test_example_six(self):
        self.assertEqual(solve("{{<ab>},{<ab>},{<ab>},{<ab>}}"), 9)

    def test_example_seven(self):
        self.assertEqual(solve("{{<!!>},{<!!>},{<!!>},{<!!>}}"), 9)

    def test_example_eight(self):
        self.assertEqual(solve("{{<a!>},{<a!>},{<a!>},{<ab>}}"), 3)

    def test_my_own_example(self):
        self.assertEqual(solve("{!{!}}"), 1)

    def test_other_example(self):
        self.assertEqual(solve("{!!{}}"), 3)

    def test_triple_exclamation_points(self):
        self.assertEqual(solve("{!!!{}}"), 1)

if __name__ == '__main__':
    unittest.main()
