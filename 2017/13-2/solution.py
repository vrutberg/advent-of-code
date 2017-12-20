#!/usr/local/bin/python3

def is_safe(scanners, delay):
    for key in scanners:
        value = scanners[key]

        if (key+delay) % ((value - 1) * 2) == 0:
            return False

    return True

def solve(input):
    scanners = dict()

    for value in input:
        scanners[int(value[0])] = int(value[1])

    delay = 0
    safe = False

    while safe is False:
        safe = is_safe(scanners, delay)

        if not safe:
            delay += 1

    return delay

if __name__ == '__main__':
    input = [s.split(": ") for s in open('./input.txt', 'r').read().strip().split("\n")]
    print("solution: {}".format(solve(input)))
