#!/usr/local/bin/python3

import operator

from lib import *

if __name__ == '__main__':

    input = open('input.txt', 'r').read().strip().split('\n')
    reverser = ModifiedErrorCorrectionReverser(input)
    print(reverser.reverse())
