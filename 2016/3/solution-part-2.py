#!/usr/local/bin/python3

if __name__ == '__main__':

    input = [s.split() for s in open('input.txt', 'r').read().strip().split('\n')]

    possibles = 0

    for row in range(0, len(input), 3):
        for column in range(3):
            triangle = sorted([int(s) for s in [input[row][column], input[row+1][column], input[row+2][column]]])

            if triangle[0] + triangle[1] > triangle[2]:
                possibles += 1

    print(possibles)
