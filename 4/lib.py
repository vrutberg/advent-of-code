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


class Sorter:
    _alphabet = list(reversed('abcdefghijklmnopqrstuvwxyz'))

    def __init__(self, s: str):
        self.s = s

    def key(self, c):
        value = self._alphabet.index(c) + 1
        factor = self.s.count(c)

        print(self.s, c, value * factor)

        return value * factor


class ChecksumCalculator:
    def _unique(self, s: str):
        unique = []
        [unique.append(i) for i in s if not unique.count(i)]
        return unique

    def calculcate_checksum(self, room: Room):
        unique = self._unique(room.name)

        sorter = Sorter(room.name)
        unique = sorted(unique, key=sorter.key)[:5]

        return unique
