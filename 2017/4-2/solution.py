#!/usr/local/bin/python3

import itertools

def solve(input: [str]):
    return sum([is_valid(passphrase) for passphrase in input])

def is_valid(passphrase: str):
    words = passphrase.split(" ")

    if len(set(words)) != len(words):
        return 0

    for index, word in enumerate(words):
        for otherIndex, otherWord in enumerate(words):
            if index == otherIndex:
                continue

            if word in [''.join(a) for a in list(itertools.permutations(otherWord))]:
                return 0

    return 1

if __name__ == '__main__':
    data = open('./input.txt', 'r').read().strip().split("\n")
    print("solution: {}".format(solve(data)))
