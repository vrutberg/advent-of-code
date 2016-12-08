#!/usr/local/bin/python3

import re

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
        factor = pow(self.s.count(c), 2)

        return value * factor


class ChecksumCalculator:
    def _unique(self, s: str):
        unique = []
        [unique.append(i) for i in s if not unique.count(i)]
        return "".join(unique)

    def calculcate_checksum(self, room: Room):
        sorter = Sorter(room.name)
        return "".join(sorted(self._unique(room.name), key=sorter.key, reverse=True)[:5])
