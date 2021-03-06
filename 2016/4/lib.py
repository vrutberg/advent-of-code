#!/usr/local/bin/python3

import re

room_regex = re.compile('((?:[a-z]+-)+)([0-9]+)\[([a-z]+)\]')

class Room:
    def __init__(self, str: str):
        matches = room_regex.findall(str)[0]
        self.raw_name = matches[0]
        self.name = matches[0].replace('-', '')
        self.sector_id = int(matches[1])
        self.expected_checksum = matches[2]


class Sorter:
    _alphabet = list(reversed('abcdefghijklmnopqrstuvwxyz'))

    def __init__(self, s: str):
        self.s = s

    def key(self, c):
        value = self._alphabet.index(c) + 1

        # TODO(vrutberg): I don't like how arbitrary a value of 1000 feels...
        factor = pow(self.s.count(c), 1000)

        return value * factor


class ChecksumCalculator:
    def _unique(self, s: str):
        unique = []
        [unique.append(i) for i in s if not unique.count(i)]
        return "".join(unique)

    def calculcate_checksum(self, room: Room):
        sorter = Sorter(room.name)
        return "".join(sorted(self._unique(room.name), key=sorter.key, reverse=True)[:5])


class RoomNameDecrypter:
    _alphabet = 'abcdefghijklmnopqrstuvwxyz'

    def decrypt(self, room: Room):
        rotations = room.sector_id % 26
        unencrypted_name = ''

        for char in room.raw_name:
            if char is '-':
                unencrypted_name += char
                continue

            new_index = (self._alphabet.index(char) + rotations) % len(self._alphabet)
            unencrypted_name += self._alphabet[new_index]

        return unencrypted_name.replace('-', ' ').strip()
