#!/usr/local/bin/python3

if __name__ == '__main__':

    input = [s.split() for s in open('input.txt', 'r').read().strip().split('\n')]

    triangles = []
    possibles = 0

    for i in range(0, len(input), 3):
        triangles.append([input[i][0], input[i+1][0], input[i+2][0]])
        triangles.append([input[i][1], input[i+1][1], input[i+2][1]])
        triangles.append([input[i][2], input[i+1][2], input[i+2][2]])

    for triangle in triangles:
        triangle = sorted(list(map(lambda s: int(s), triangle)))

        if triangle[0] + triangle[1] > triangle[2]:
            possibles += 1

    print(possibles)
