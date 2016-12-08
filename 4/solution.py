#!/usr/local/bin/python3

from lib import *

import operator
import re


if __name__ == '__main__':

    input = open('input.txt', 'r').read().strip().split('\n')

    sum = 0
    regex = re.compile('((?:[a-z]+-)+)([0-9]+)\[([a-z]+)\]')
    calculator = ChecksumCalculator()

    for room_string in input:
        room = Room(room_string)
        checksum = calculator.calculcate_checksum(room)

        if checksum == room.expected_checksum:
            sum += room.sector_id

    print(sum)
