#!/usr/local/bin/python3

from lib import *

if __name__ == '__main__':

    input = open('input.txt', 'r').read().strip().split('\n')

    directions = list(map(lambda s: DirectionFactory.from_string(s), input))
    instructions = list(map(lambda d: KeypadInstruction(d), directions))

    keypad = Keypad(instructions)
    keypad.follow_instructions()

    print(keypad.digits)
