#!/usr/local/bin/python3

import unittest

from lib import *

class ErrorCorrectionReverserTest(unittest.TestCase):
    def test_example(self):
        file = open('test_input.txt', 'r')
        input = file.read().strip().split('\n')
        file.close()
        reverser = ErrorCorrectionReverser(input)
        self.assertEqual(reverser.reverse(), 'easter')


if __name__ == '__main__':
    unittest.main()
