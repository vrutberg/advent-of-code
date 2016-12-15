#!/usr/local/bin/python3

import unittest

from lib import *

class TLSDeciderTest(unittest.TestCase):
    def test_example_one(self):
        self.assertTrue(TLSDecider.decide('abba[mnop]qrst'))

    def test_example_two(self):
        self.assertFalse(TLSDecider.decide('abcd[bddb]xyyx'))

    def test_example_three(self):
        self.assertFalse(TLSDecider.decide('aaaa[qwer]tyui'))

    def test_example_four(self):
        self.assertTrue(TLSDecider.decide('ioxxoj[asdfgh]zxcvbn'))


if __name__ == '__main__':
    unittest.main()
