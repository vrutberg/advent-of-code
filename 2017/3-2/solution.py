#!/usr/local/bin/python3

from collections import defaultdict

class Solver:
    grid = defaultdict(dict)

    def solve(self, input: int):
        self.grid[0][0] = 1
        self.grid[1][0] = 1

        level = 1
        while True:
            value = self.fill(level, input)
            level += 1

            if not value is None:
                return value

    def fill(self, level: int, target: int):
        steps = level * 2 + 1

        x = level
        y = level

        for i in range(0, steps * 4 - 2):
            value = self.valueFor(x, y)
            self.grid[x][y] = value

            if value > target:
                return value

            if i < steps - 1:
                x -= 1

            elif i >= steps - 1 and i < (steps - 1) * 2:
                y -= 1

            elif i >= (steps - 1) * 2 and i < (steps - 1) * 3 + 1:
                x += 1

            else:
                y += 1

    def valueFor(self, x: int, y: int):
        nw = self.value_at_coordinate(x - 1, y + 1)
        n = self.value_at_coordinate(x, y + 1)
        ne = self.value_at_coordinate(x + 1, y + 1)
        w = self.value_at_coordinate(x - 1, y)
        e = self.value_at_coordinate(x + 1, y)
        sw = self.value_at_coordinate(x - 1, y - 1)
        s = self.value_at_coordinate(x, y - 1)
        se = self.value_at_coordinate(x + 1, y - 1)

        return nw + n + ne + w + e + sw + s + se

    def value_at_coordinate(self, x: int, y: int):
        try:
            return self.grid[x][y]
        except:
            return 0

if __name__ == '__main__':
    print("solution: {}".format(Solver().solve(361527)))
