#!/usr/local/bin/python3

import unittest
from lib import *

class DirectionTest(unittest.TestCase):

    def test_next(self):
        self.assertEqual(Direction.north.next(), Direction.east)
        self.assertEqual(Direction.east.next(), Direction.south)
        self.assertEqual(Direction.south.next(), Direction.west)
        self.assertEqual(Direction.west.next(), Direction.north)

    def test_prev(self):
        self.assertEqual(Direction.north.prev(), Direction.west)
        self.assertEqual(Direction.east.prev(), Direction.north)
        self.assertEqual(Direction.south.prev(), Direction.east)
        self.assertEqual(Direction.west.prev(), Direction.south)

class InstructionTest(unittest.TestCase):

    def test_from_string_left(self):
        instruction = Instruction.from_string('L1')

        self.assertEqual(instruction.turn, Turn.left)
        self.assertEqual(instruction.steps, 1)

    def test_from_string_right(self):
        instruction = Instruction.from_string('R1')

        self.assertEqual(instruction.turn, Turn.right)
        self.assertEqual(instruction.steps, 1)

class PositionTest(unittest.TestCase):

    def test_equals(self):
        self.assertEqual(Position(1, 1), Position(1, 1))

    def test_not_equals(self):
        self.assertNotEqual(Position(1, 1), Position(1, 2))

    def test_move_north(self):
        self.assertEqual(Position(0, 0).move(Direction.north, 1), Position(0, 1))

    def test_move_east(self):
        self.assertEqual(Position(0, 0).move(Direction.east, 1), Position(1, 0))

    def test_move_south(self):
        self.assertEqual(Position(0, 0).move(Direction.south, 1), Position(0, -1))

    def test_move_west(self):
        self.assertEqual(Position(0, 0).move(Direction.west, 1), Position(-1, 0))

    def test_positions_to_y(self):
        position1 = Position(0, 0)
        position2 = Position(0, 2)

        between = position1.positions_to(position2)

        self.assertEqual(len(between), 2)
        self.assertEqual(between[0], Position(0, 1))
        self.assertEqual(between[1], Position(0, 2))

    def test_positions_to_x(self):
        position1 = Position(0, 0)
        position2 = Position(2, 0)

        between = position1.positions_to(position2)

        self.assertEqual(len(between), 2)
        self.assertEqual(between[0], Position(1, 0))
        self.assertEqual(between[1], Position(2, 0))

    def test_positions_to_y_negative(self):
        position1 = Position(0, 0)
        position2 = Position(0, -2)

        between = position1.positions_to(position2)

        self.assertEqual(len(between), 2)
        self.assertEqual(between[0], Position(0, -1))
        self.assertEqual(between[1], Position(0, -2))

    def test_positions_to_x_negative(self):
        position1 = Position(0, 0)
        position2 = Position(-2, 0)

        between = position1.positions_to(position2)

        self.assertEqual(len(between), 2)
        self.assertEqual(between[0], Position(-1, 0))
        self.assertEqual(between[1], Position(-2, 0))

class StreetGridTest(unittest.TestCase):

    def test_proces_instruction_updates_current_direction(self):
        grid = StreetGrid(Direction.north)
        instruction = Instruction(1, Turn.left)

        grid.process_instruction(instruction)

        self.assertEqual(grid.current_direction, Direction.west)

    def test_proces_instruction_updates_current_position(self):
        grid = StreetGrid(Direction.north)
        instruction = Instruction(1, Turn.left)

        grid.process_instruction(instruction)
        current_position = grid.current_position

        self.assertEqual(current_position.x, -1)
        self.assertEqual(current_position.y, 0)

class BlockCalculatorTest(unittest.TestCase):

    def test_example_one(self):
        grid = StreetGrid(Direction.north)
        calculator = BlockCalculator()

        grid.process_instruction(Instruction(2, Turn.right))
        grid.process_instruction(Instruction(3, Turn.left))

        distance = calculator.calculate_distance(Position(), grid.current_position)

        self.assertEqual(distance, 5)

    def test_example_two(self):
        grid = StreetGrid(Direction.north)
        calculator = BlockCalculator()

        grid.process_instruction(Instruction(2, Turn.right))
        grid.process_instruction(Instruction(2, Turn.right))
        grid.process_instruction(Instruction(2, Turn.right))

        distance = calculator.calculate_distance(Position(), grid.current_position)

        self.assertEqual(distance, 2)

    def test_example_three(self):
        grid = StreetGrid(Direction.north)
        calculator = BlockCalculator()

        grid.process_instruction(Instruction(5, Turn.right))
        grid.process_instruction(Instruction(5, Turn.left))
        grid.process_instruction(Instruction(5, Turn.right))
        grid.process_instruction(Instruction(3, Turn.right))

        distance = calculator.calculate_distance(Position(), grid.current_position)

        self.assertEqual(distance, 12)

class DuplicatePositionFinderTest(unittest.TestCase):

    def test_example(self):
        instructions = [Instruction(8, Turn.right),
                        Instruction(4, Turn.right),
                        Instruction(4, Turn.right),
                        Instruction(8, Turn.right)]

        finder = DuplicatePositionFinder(instructions)

        position = finder.find()

        self.assertEqual(position, Position(4, 0))

if __name__ == '__main__':
    unittest.main()
