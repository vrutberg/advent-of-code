#!/usr/local/bin/python3

import operator

class ErrorCorrectionReverser:

    def __init__(self, input):
        self.input = input

    def reverse(self):
        alphabet = 'abcdefghijklmnopqrstuvwxyz'
        occurrences = [dict([(x, 0) for x in alphabet]) for s in self.input[0]]

        for line in self.input:
            for index, char in enumerate(line):
                occurrences[index][char] += 1

        return "".join([sorted(x.items(), key=operator.itemgetter(1), reverse=True)[0][0] for x in occurrences])
