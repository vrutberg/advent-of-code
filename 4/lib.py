#!/usr/local/bin/python3

import re
import operator

room_regex = re.compile('((?:[a-z]+-)+)([0-9]+)\[([a-z]+)\]')

class Room:
    def __init__(self, str: str):
        matches = room_regex.findall(str)[0]
        self.name = matches[0].replace('-', '')
        self.sector_id = int(matches[1])
        self.expected_checksum = matches[2]


class ChecksumCalculator:
    def _unique(self, s: str):
        unique = []
        [unique.append(i) for i in s if not unique.count(i)]
        return unique

    def calculcate_checksum(self, room: Room):
        unique = self._unique(room.name)

        occurrences = []

        for i in unique:
            occurrences.append((i, room.name.count(i)))

        print(occurrences)
        sorted_occurrences = list(sorted(occurrences, key=operator.itemgetter(0)))
        print(sorted_occurrences)
        sorted_occurrences = list(sorted(occurrences, key=operator.itemgetter(1), reverse=True))[:5]
        print(sorted_occurrences)
        checksum = ""

        for s in sorted_occurrences:
            checksum += s[0]

        return checksum
