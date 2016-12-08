#!/usr/local/bin/python3

import unittest
from lib import *

class RoomTest(unittest.TestCase):
    def test_parsing(self):
        room = Room('aaaaa-bbb-z-y-x-123[abxyz]')

        self.assertEqual(room.name, 'aaaaabbbzyx')
        self.assertEqual(room.sector_id, 123)
        self.assertEqual(room.expected_checksum, 'abxyz')

class ChecksumCalculatorTest(unittest.TestCase):
    def test_example_one(self):
        room = Room('aaaaa-bbb-z-y-x-123[abxyz]')
        self.assertEqual(ChecksumCalculator().calculcate_checksum(room), 'abxyz')

    def test_example_two(self):
        room = Room('a-b-c-d-e-f-g-h-987[abcde]')
        self.assertEqual(ChecksumCalculator().calculcate_checksum(room), 'abcde')

    def test_example_three(self):
        room = Room('not-a-real-room-404[oarel]')
        self.assertEqual(ChecksumCalculator().calculcate_checksum(room), 'oarel')


if __name__ == '__main__':
    unittest.main()
