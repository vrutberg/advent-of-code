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
        scanners.update({ int(value[0]): Scanner(int(value[1]))})

    severity = 0

    for pos in range(max(list(scanners.keys()))+1):
        if scanners[pos] is not None and scanners[pos].position == 0:
            severity += pos * scanners[pos]._size

        for p in scanners:
            if scanners[p] is not None:
                scanners[p].move()

        pos += 1

    return severity

if __name__ == '__main__':
    input = [s.split(": ") for s in open('./input.txt', 'r').read().strip().split("\n")]
    print("solution: {}".format(solve(input)))
