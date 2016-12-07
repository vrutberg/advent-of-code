#!/usr/local/bin/python3

from enum import Enum, IntEnum

class Turn(Enum):
    left = 1
    right = 2


class Direction(IntEnum):
    north = 1
    east = 2
    south = 3
    west = 4

    def turn(self, turn: Turn):
        if turn is Turn.left:
            return self.prev()
        else:
            return self.next()

    def next(self):
        if self is Direction.west:
            return Direction.north
        else:
            return Direction(self+1)

    def prev(self):
        if self is Direction.north:
            return Direction.west
        else:
            return Direction(self-1)


class Instruction:
    def __init__(self, steps: int, turn: Turn):
        self.steps = steps
        self.turn = turn

    @staticmethod
    def from_string(s: str):
        direction_string = s[0]
        steps_string = s[1:]

        if direction_string is 'L':
            turn = Turn.left
        elif direction_string is 'R':
            turn = Turn.right

        return Instruction(int(steps_string), turn)

    def __str__(self):
        return "Instruction(steps: {}, turn: {})".format(self.steps, self.turn)

    def __repr__(self):
        return self.__str__()


class Position:

    def __init__(self, x: int = 0, y: int = 0):
        self.x = x
        self.y = y

    def move(self, direction: Direction, steps: int):
        if direction is Direction.north:
            return Position(self.x, self.y + steps)
        elif direction is Direction.east:
            return Position(self.x + steps, self.y)
        elif direction is Direction.south:
            return Position(self.x, self.y - steps)
        elif direction is Direction.west:
            return Position(self.x - steps, self.y)

    def positions_to(self, other):
        if not (self.x == other.x or self.y == other.y):
            return NotImplemented

        positions = []

        if self.x == other.x:
            step = 1 if self.y < other.y else -1

            for y in range(self.y, other.y, step):
                positions.append(Position(self.x, y + step))

        elif self.y == other.y:
            step = 1 if self.x < other.x else -1

            for x in range(self.x, other.x, step):
                positions.append(Position(x + step, self.y))

        return positions

    def __str__(self):
        return "Position(x: {}, y: {})".format(self.x, self.y)

    def __repr__(self):
        return self.__str__()

    def __eq__(self, other):
        if isinstance(other, self.__class__):
            return self.__dict__ == other.__dict__

        return False

    def __ne__(self, other):
        return not self.__eq__(other)


class StreetGrid:

    def __init__(self, direction: Direction = Direction.north):
        self.current_direction = direction
        self.current_position = Position()

    def process_instruction(self, instruction: Instruction):
        self.current_direction = self.current_direction.turn(instruction.turn)
        self.current_position = self.current_position.move(self.current_direction, instruction.steps)


class BlockCalculator:
    def calculate_distance(self, from_pos: Position, to_pos: Position):
        return abs(to_pos.x) + abs(to_pos.y)

class DuplicatePositionFinder:

    def __init__(self, instructions):
        self.instructions = instructions
        self.grid = StreetGrid()
        self.visited_positions = []

    def find(self):
        previous_position = None

        for instruction in self.instructions:
            previous_position = self.grid.current_position

            self.grid.process_instruction(instruction)

            if previous_position is not None:
                positions_to = previous_position.positions_to(self.grid.current_position)

                for position in positions_to:
                    for otherPosition in self.visited_positions:
                        if position == otherPosition:
                            return position

                    self.visited_positions.append(position)

        return None
