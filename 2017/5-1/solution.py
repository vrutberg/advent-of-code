#!/usr/local/bin/python3

def solve(input):
    cursor = 0
    iterations = 0

    while cursor >= 0 and cursor <= len(input) - 1:
        old_cursor = cursor
        cursor += input[cursor]
        input[old_cursor] += 1

        iterations += 1

    return iterations

if __name__ == '__main__':
    input = [int(str) for str in open('./input.txt', 'r').read().strip().split("\n")]
    print("solution: {}".format(solve(input)))
