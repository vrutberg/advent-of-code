#!/usr/local/bin/python3

import re

room_regex = re.compile('((?:[a-z]+-)+)([0-9]+)\[([a-z]+)\]')

class Room:
    def __init__(self, str: str):
        matches = room_regex.findall(str)[0]
        self.name = matches[0].replace('-', '')
        self.sector_id = int(matches[1])
        self.expected_checksum = matches[2]


class ChecksumCalculator:
    @staticmethod
    def calculcate_checksum(room: Room):
        return ''
        
