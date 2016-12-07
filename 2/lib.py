#!/usr/local/bin/python3

from enum import Enum, IntEnum

class Direction(Enum):
    up = 1
    right = 2
    down = 3
    left = 4


class DirectionFactory:
    @staticmethod
    def from_char(c: str):
        if c not in 'LURD':
            return NotImplemented

        if c is 'L':
            return Direction.left
        elif c is 'U':
            return Direction.up
        elif c is 'R':
            return Direction.right
        elif c is 'D':
            return Direction.down

    @staticmethod
    def from_string(s: str):
        directions = []

        for c in s:
            directions.append(DirectionFactory.from_char(c))

        return directions


class KeypadPosition:
    def __init__(self, x: int = 0, y: int = 0):
        self.x = x
        self.y = y

    def move(self, direction: Direction):
        if direction is Direction.up:
            return KeypadPosition(self.x, min(1, self.y + 1))
        elif direction is Direction.right:
            return KeypadPosition(min(1, self.x + 1), self.y)
        elif direction is Direction.down:
            return KeypadPosition(self.x, max(-1, self.y - 1))
        elif direction is Direction.left:
            return KeypadPosition(max(-1, self.x - 1), self.y)

    def to_digit(self):
        if self.x is -1 and self.y is 1:
            return 1
        elif self.x is 0 and self.y is 1:
            return 2
        elif self.x is 1 and self.y is 1:
            return 3
        elif self.x is -1 and self.y is 0:
            return 4
        elif self.x is 0 and self.y is 0:
            return 5
        elif self.x is 1 and self.y is 0:
            return 6
        elif self.x is -1 and self.y is -1:
            return 7
        elif self.x is 0 and self.y is -1:
            return 8
        elif self.x is 1 and self.y is -1:
            return 9

    def __str__(self):
        return "{}{}".format(type(self).__name__, self.__dict__)

    def __repr__(self):
        return self.__str__()

    def __eq__(self, other):
        if isinstance(other, self.__class__):
            return self.__dict__ == other.__dict__

        return False

    def __ne__(self, other):
        return not self.__eq__(other)


class DiamondKeypadPosition(KeypadPosition):
    def move(self, direction: Direction):
        if direction is Direction.up:
            if abs(self.x) is 2:
                return DiamondKeypadPosition(self.x, self.y)
            elif abs(self.x) is 1:
                return DiamondKeypadPosition(self.x, min(1, self.y + 1))
            else:
                return DiamondKeypadPosition(self.x, min(2, self.y + 1))


        elif direction is Direction.right:
            return DiamondKeypadPosition(min(1, self.x + 1), self.y)
        elif direction is Direction.down:
            return DiamondKeypadPosition(self.x, min(1, self.y + 1))
        elif direction is Direction.left:
            return DiamondKeypadPosition(max(-1, self.x - 1), self.y)

    def to_digit(self):
        if self.x is -1 and self.y is -1:
            return 1
        elif self.x is 0 and self.y is -1:
            return 2
        elif self.x is 1 and self.y is -1:
            return 3
        elif self.x is -1 and self.y is 0:
            return 4
        elif self.x is 0 and self.y is 0:
            return 5
        elif self.x is 1 and self.y is 0:
            return 6
        elif self.x is -1 and self.y is 1:
            return 7
        elif self.x is 0 and self.y is 1:
            return 8
        elif self.x is 1 and self.y is 1:
            return 9


class KeypadInstruction:
    def __init__(self, directions):
        self.directions = directions

    def follow(self):
        current_position = KeypadPosition()

        for direction in self.directions:
            current_position = current_position.move(direction)

        return current_position.to_digit()


class Keypad:
    def __init__(self, instructions):
        self.digits = []
        self.instructions = instructions

    def follow_instructions(self):
        for instruction in self.instructions:
            self.digits.append(instruction.follow())
