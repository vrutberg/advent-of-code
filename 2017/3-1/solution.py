#!/usr/local/bin/python3

from lib import *

def find_corner(number):
    if number == 1:
        return 0

    if number == 2 or number == 3:
        return 1

    currentNumber = 3
    step = 8
    offset = 2

    for i in range(1, 10000000):
        nextCurrentNumber = offset + currentNumber + (step * i)

        if number >= currentNumber and number < nextCurrentNumber:
            print("the number {} is on corner: {}".format(number, i))
            return i

        currentNumber = nextCurrentNumber

def numbers_per_face(layer):
    if layer == 0:
        return 1

    


if __name__ == '__main__':
    input = 361527


    find_corner(100)
    find_corner(31)
    find_corner(30)
    find_corner(13)
    find_corner(12)

    print("solution: {}".format(Solver().solve(input)))
