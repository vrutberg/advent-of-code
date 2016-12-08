#!/usr/local/bin/python3

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

    for room in input:
        matches = regex.findall(room)[0]
        name = matches[0].replace('-', '')
        sector_id = int(matches[1])
        expected_checksum = matches[2]
        unique = uniq(name)

        occurrences = {}

        for i in unique:
            occurrences[i] = name.count(i)

        sorted_occurrences = list(reversed(sorted(occurrences.items(), key=operator.itemgetter(1))))[:5]
        checksum = ""

        for s in sorted_occurrences:
            checksum += s[0]

        if checksum == expected_checksum:
            sum += sector_id

    print(sum)
