#!/usr/local/bin/python3

import unittest
from lib import *

class RoomTest(unittest.TestCase):
    def test_parsing(self):
        room = Room('aaaaa-bbb-z-y-x-123[abxyz]')

        self.assertEqual(room.name, 'aaaaabbbzyx')
        self.assertEqual(room.sector_id, 123)
        self.assertEqual(room.expected_checksum, 'abxyz')


if __name__ == '__main__':
    unittest.main()
