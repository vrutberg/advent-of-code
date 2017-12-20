#!/usr/local/bin/python3

from collections import defaultdict

class Scanner:
    position = 0
    _moving_up = True

    def __init__(self, size):
        self._size = size

    def move(self):
        if self._moving_up:
            if self.position == self._size - 1:
                self.position -= 1
                self._moving_up = False
            else:
                self.position += 1

        else:
            if self.position == 0:
                self.position += 1
                self._moving_up = True
            else:
                self.position -= 1


def solve(input):
    scanners = defaultdict(lambda: None)

    for value in input:
        scanners.update({ int(value[0]): int(value[1])})

    max_value = max(list(scanners.keys()))
    positions = list(range(max_value+1))

    for index, value in enumerate(positions):
        if scanners[index] is None:
            positions[index] = None
        else:
            positions[index] = Scanner(scanners[index])

    severity = 0

    for pos in range(max_value+1):
        if positions[pos] is not None and positions[pos].position == 0:
            severity += pos * positions[pos]._size

        for p in positions:
            if p is not None:
                p.move()

        pos += 1

    return severity

if __name__ == '__main__':
    input = [s.split(": ") for s in open('./input.txt', 'r').read().strip().split("\n")]
    print("solution: {}".format(solve(input)))
