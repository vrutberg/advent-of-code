#!/usr/local/bin/python3

def solve(input):
    scanners = dict()

    for value in input:
        scanners[int(value[0])] = int(value[1])

    severity = 0

    for key in scanners:
        value = scanners[key]

        if key % ((value - 1) * 2) == 0:
            severity += key * value

    return severity

if __name__ == '__main__':
    input = [s.split(": ") for s in open('./input.txt', 'r').read().strip().split("\n")]
    print("solution: {}".format(solve(input)))
