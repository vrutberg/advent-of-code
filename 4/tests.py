#!/usr/local/bin/python3

import unittest
from lib import *

class RoomTest(unittest.TestCase):
    def test_parsing(self):
        room = Room('aaaaa-bbb-z-y-x-123[abxyz]')

        self.assertEqual(room.name, 'aaaaabbbzyx')
        self.assertEqual(room.sector_id, 123)
        self.assertEqual(room.expected_checksum, 'abxyz')


class SorterTest(unittest.TestCase):
    def test_sorting(self):
        sorter = Sorter('kalabalik')
        self.assertTrue(sorter.key('a') > sorter.key('k'))
        self.assertTrue(sorter.key('k') > sorter.key('l'))
        self.assertTrue(sorter.key('l') > sorter.key('b'))
        self.assertTrue(sorter.key('b') > sorter.key('i'))

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

    def test_example_from_reddit(self):
        room = Room('jvuzbtly-nyhkl-yhiipa-zavyhnl-123[yhlai]')
        self.assertEqual(ChecksumCalculator().calculcate_checksum(room), 'yhlai')

    def test_unique(self):
        self.assertEqual(ChecksumCalculator()._unique('aaabbbccc'), 'abc')

    def test_unique_preserves_order(self):
        self.assertEqual(ChecksumCalculator()._unique('abaca'), 'abc')

if __name__ == '__main__':
    unittest.main()
