#!/usr/local/bin/python3

def solve(input: [str]):
    return sum([is_valid(passphrase) for passphrase in input])

def is_valid(passphrase: str):
    sorted_words = [''.join(sorted(c)) for c in [word for word in passphrase.split(" ")]]
    return 1 if len(set(sorted_words)) == len(sorted_words) else 0

if __name__ == '__main__':
    data = open('./input.txt', 'r').read().strip().split("\n")
    print("solution: {}".format(solve(data)))
