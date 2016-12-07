#!/usr/local/bin/python3

import operator

def uniq(seq):
   unique = []
   [unique.append(i) for i in seq if not unique.count(i)]
   return unique


if __name__ == '__main__':

    input = open('input.txt', 'r').read().strip().split('\n')

    sum = 0

    for room in input:
        split = room.split('-')
        name = "".join(split[:len(split) - 1])
        last = split[-1:][0].split('[')
        sector_id = int(last[0])
        expected_checksum = last[1][:-1]
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
