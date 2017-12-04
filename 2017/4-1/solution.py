#!/usr/local/bin/python3

def solve(input: [str]):
    return sum([is_valid(passphrase) for passphrase in input])

def is_valid(passphrase: str):
    words = passphrase.split(" ")
    return 1 if len(set(words)) == len(words) else 0

if __name__ == '__main__':
    data = open('./input.txt', 'r').read().strip().split("\n")
    print("solution: {}".format(solve(data)))
