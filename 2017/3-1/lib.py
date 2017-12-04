#!/usr/local/bin/python3

class Solver:
    def solve(self, input: int):
        corner = self.find_corner(361527)
        target_corner = self.traverse(corner[0], corner[1])
        return target_corner[0] + target_corner[1]

    def find_corner(self, number):
        if number == 1:
            return 0

        if number == 2 or number == 3:
            return 1

        currentNumber = 3
        step = 8
        offset = 2

        i = 1
        while True:
            nextCurrentNumber = offset + currentNumber + (step * i)

            if number >= currentNumber and number < nextCurrentNumber:
                return ((i, i), number-currentNumber)

            currentNumber = nextCurrentNumber
            i += 1


    def traverse(self, point, numbers):
        per_face = self.numbers_per_face(point[1])
        x = point[0]
        y = point[1]

        for i in range(0, numbers):
            if i >= 0 and i < per_face - 1:
                x -= 1

            elif i >= per_face - 1 and i < (per_face -1) * 2:
                y -= 1

            elif i >= (per_face -1) * 2 and i < ((per_face -1) * 3) + 1:
                x += 1

            else:
                y += 1

        return (x, y)


    def numbers_per_face(self, layer):
        return layer * 2 + 1
