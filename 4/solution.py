#!/usr/local/bin/python3

from lib import *

import operator
import re

def uniq(seq):
   unique = []
   [unique.append(i) for i in seq if not unique.count(i)]
   return unique


if __name__ == '__main__':

    input = open('input.txt', 'r').read().strip().split('\n')

    sum = 0
    regex = re.compile('((?:[a-z]+-)+)([0-9]+)\[([a-z]+)\]')

    for room_string in input:
        room = Room(room_string)
        unique = uniq(room.name)

        occurrences = {}

        for i in unique:
            occurrences[i] = room.name.count(i)

        sorted_occurrences = list(reversed(sorted(occurrences.items(), key=operator.itemgetter(1))))[:5]
        checksum = ""

        for s in sorted_occurrences:
            checksum += s[0]

        if checksum == room.expected_checksum:
            sum += room.sector_id

    print(sum)
