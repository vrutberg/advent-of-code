#!/usr/local/bin/python3

from lib import *

if __name__ == '__main__':

    input = open('./input.txt', 'r').read().strip()

    print("solution: {}".format(Solver().solve(input)))
