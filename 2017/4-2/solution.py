#!/usr/local/bin/python3

import itertools

def solve(input: [str]):
    return sum([is_valid(passphrase) for passphrase in input])

def is_valid(passphrase: str):
    words = passphrase.split(" ")

    if len(set(words)) != len(words):
        return 0

    sorted_words = [''.join(sorted(c)) for c in [word for word in words]]

    if len(set(sorted_words)) != len(sorted_words):
        return 0

    return 1

if __name__ == '__main__':
    data = open('./input.txt', 'r').read().strip().split("\n")
    print("solution: {}".format(solve(data)))
