#!/usr/local/bin/python3

def solve(input):
    lower_bound = 0
    upper_bound = len(input) - 1
    cursor = 0
    iterations = 0

    while True:
        if cursor < lower_bound or cursor > upper_bound:
            return iterations

        old_cursor = cursor
        cursor += input[cursor]
        input[old_cursor] += 1

        iterations += 1

if __name__ == '__main__':
    input = [int(str) for str in open('./input.txt', 'r').read().strip().split("\n")]
    print("solution: {}".format(solve(input)))
