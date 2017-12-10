#!/usr/local/bin/python3

def solve(input):
    opened_groups = 0
    score = 0
    is_garbage = False
    is_cancelled = False

    for index, c in enumerate(input):
        if is_cancelled:
            is_cancelled = False
            continue

        if c == '!':
            is_cancelled = True

        elif c == '<' and not is_garbage:
            is_garbage = True

        elif c == '>':
            is_garbage = False

        elif is_garbage:
            score += 1

    return score


if __name__ == '__main__':
    input = open('./input.txt', 'r').read().strip()
    print("solution: {}".format(solve(input)))
