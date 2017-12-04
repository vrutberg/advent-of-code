#!/usr/local/bin/python3

import itertools

def solve(input: [str]):
    valid_passhprases = 0

    for passhprase in input:
        if is_valid(passhprase):
            valid_passhprases += 1

    return valid_passhprases

def is_valid(passphrase: str):
    words = passphrase.split(" ")

    for index, element in enumerate(words):
        for otherIndex, otherElement in enumerate(words):
            if index == otherIndex:
                continue

            if element == otherElement:
                return False

    return True

if __name__ == '__main__':
    data = open('./input.txt', 'r').read().strip().split("\n")
    print("solution: {}".format(solve(data)))
