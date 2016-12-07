#!/usr/local/bin/python3

import unittest
from lib import *

class KeypadPositionTest(unittest.TestCase):

    def test_move_up(self):
        self.assertEqual(KeypadPosition().move(Direction.up), KeypadPosition(0, 1))

    def test_move_right(self):
        self.assertEqual(KeypadPosition().move(Direction.right), KeypadPosition(1, 0))

    def test_move_down(self):
        self.assertEqual(KeypadPosition().move(Direction.down), KeypadPosition(0, -1))

    def test_move_left(self):
        self.assertEqual(KeypadPosition().move(Direction.left), KeypadPosition(-1, 0))

    def test_move_up_is_capped(self):
        self.assertEqual(KeypadPosition(0, 1).move(Direction.up), KeypadPosition(0, 1))

    def test_move_right_is_capped(self):
        self.assertEqual(KeypadPosition(1, 0).move(Direction.right), KeypadPosition(1, 0))

    def test_move_down_is_capped(self):
        self.assertEqual(KeypadPosition(0, -1).move(Direction.down), KeypadPosition(0, -1))

    def test_move_left_is_capped(self):
        self.assertEqual(KeypadPosition(-1, 0).move(Direction.left), KeypadPosition(-1, 0))

    def test_to_digit(self):
        self.assertEqual(KeypadPosition(-1, 1).to_digit(), 1)
        self.assertEqual(KeypadPosition(0, 1).to_digit(), 2)
        self.assertEqual(KeypadPosition(1, 1).to_digit(), 3)
        self.assertEqual(KeypadPosition(-1, 0).to_digit(), 4)
        self.assertEqual(KeypadPosition(0, 0).to_digit(), 5)
        self.assertEqual(KeypadPosition(1, 0).to_digit(), 6)
        self.assertEqual(KeypadPosition(-1, -1).to_digit(), 7)
        self.assertEqual(KeypadPosition(0, -1).to_digit(), 8)
        self.assertEqual(KeypadPosition(1, -1).to_digit(), 9)


class DiamondKeypadPositionTest(unittest.TestCase):
    def test_move_up_is_capped(self):
        self.assertEqual(DiamondKeypadPosition(-2, 0).move(Direction.up), DiamondKeypadPosition(-2, 0))
        self.assertEqual(DiamondKeypadPosition(-1, 1).move(Direction.up), DiamondKeypadPosition(-1, 1))
        self.assertEqual(DiamondKeypadPosition(0, 2).move(Direction.up), DiamondKeypadPosition(0, 2))
        self.assertEqual(DiamondKeypadPosition(1, 1).move(Direction.up), DiamondKeypadPosition(1, 1))
        self.assertEqual(DiamondKeypadPosition(2, 0).move(Direction.up), DiamondKeypadPosition(2, 0))

    def test_move_right_is_capped(self):
        self.assertEqual(DiamondKeypadPosition(0, 2).move(Direction.right), DiamondKeypadPosition(0, 2))
        self.assertEqual(DiamondKeypadPosition(1, 1).move(Direction.right), DiamondKeypadPosition(1, 1))
        self.assertEqual(DiamondKeypadPosition(2, 0).move(Direction.right), DiamondKeypadPosition(2, 0))
        self.assertEqual(DiamondKeypadPosition(1, -1).move(Direction.right), DiamondKeypadPosition(1, -1))
        self.assertEqual(DiamondKeypadPosition(0, -2).move(Direction.right), DiamondKeypadPosition(0, -2))

    def test_move_down_is_capped(self):
        self.assertEqual(DiamondKeypadPosition(-2, 0).move(Direction.down), DiamondKeypadPosition(-2, 0))
        self.assertEqual(DiamondKeypadPosition(-1, -1).move(Direction.down), DiamondKeypadPosition(-1, -1))
        self.assertEqual(DiamondKeypadPosition(0, -2).move(Direction.down), DiamondKeypadPosition(0, -2))
        self.assertEqual(DiamondKeypadPosition(1, -1).move(Direction.down), DiamondKeypadPosition(1, -1))
        self.assertEqual(DiamondKeypadPosition(2, 0).move(Direction.down), DiamondKeypadPosition(2, 0))

    def test_move_left_is_capped(self):
        self.assertEqual(DiamondKeypadPosition(0, 2).move(Direction.left), DiamondKeypadPosition(0, 2))
        self.assertEqual(DiamondKeypadPosition(-1, 1).move(Direction.left), DiamondKeypadPosition(-1, 1))
        self.assertEqual(DiamondKeypadPosition(-2, 0).move(Direction.left), DiamondKeypadPosition(-2, 0))
        self.assertEqual(DiamondKeypadPosition(-1, -1).move(Direction.left), DiamondKeypadPosition(-1, -1))
        self.assertEqual(DiamondKeypadPosition(0, -2).move(Direction.left), DiamondKeypadPosition(0, -2))


class KeypadInstructionTest(unittest.TestCase):
    def test_example_one(self):
        directions = [Direction.up, Direction.left, Direction.left]
        self.assertEqual(KeypadInstruction(directions).follow(), 1)

    def test_example_two(self):
        directions = [Direction.right, Direction.right, Direction.down, Direction.down, Direction.down]
        self.assertEqual(KeypadInstruction(directions).follow(), 9)

    def test_example_three(self):
        directions = [Direction.left, Direction.up, Direction.right, Direction.down, Direction.left]
        self.assertEqual(KeypadInstruction(directions).follow(), 8)

    def test_example_three(self):
        directions = [Direction.up, Direction.up, Direction.up, Direction.up, Direction.down]
        self.assertEqual(KeypadInstruction(directions).follow(), 5)

class DirectionFactoryTests(unittest.TestCase):
    def test_from_string(self):
        self.assertEqual(DirectionFactory.from_string('LURD'), [Direction.left, Direction.up, Direction.right, Direction.down])

    def test_from_char(self):
        self.assertEqual(DirectionFactory.from_char('L'), Direction.left)

    def test_from_char_unsupported_char(self):
        self.assertEqual(DirectionFactory.from_char('X'), NotImplemented)

if __name__ == '__main__':
    unittest.main()
