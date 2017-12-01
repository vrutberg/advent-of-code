#!/usr/local/bin/python3

from lib import *

if __name__ == '__main__':

    input = open('input.txt', 'r').read().strip().split(', ')
    instructions = list(map(lambda s: Instruction.from_string(s), input))
    grid = StreetGrid(Direction.north)

    for instruction in instructions:
        grid.process_instruction(instruction)

    distance = BlockCalculator().calculate_distance(Position(), grid.current_position)
    print("Destination is {} blocks away".format(distance))
