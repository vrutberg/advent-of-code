#!/usr/local/bin/python3

from lib import *

if __name__ == '__main__':

    input = open('input.txt', 'r').read().strip().split(', ')
    instructions = list(map(lambda s: Instruction.from_string(s), input))

    position = DuplicatePositionFinder(instructions).find()

    if position is not None:
        print("First repeated position: {}".format(position))
        print("At {} blocks away".format(BlockCalculator().calculate_distance(Position(0, 0), position)))
        exit()

    print("No repeated positions")
