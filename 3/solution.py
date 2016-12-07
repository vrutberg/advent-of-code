#!/usr/local/bin/python3

if __name__ == '__main__':

    input = [s.split() for s in open('input.txt', 'r').read().strip().split('\n')]

    possibles = 0

    for triangle in input:
        triangle = sorted(list(map(lambda s: int(s), triangle)))

        if triangle[0] + triangle[1] > triangle[2]:
            possibles += 1

    print(possibles)
