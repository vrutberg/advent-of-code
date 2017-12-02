#!/usr/local/bin/python3

from lib import *

if __name__ == '__main__':
    input = [str.split("\t") for str in open('./input.txt', 'r').read().strip().split("\n")]

    print("solution: {}".format(Solver().solve(input)))
