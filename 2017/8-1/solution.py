#!/usr/local/bin/python3

from collections import defaultdict

register = defaultdict(lambda: 0)
comparators = {
    '>=': lambda x, y: x >= y,
    '!=': lambda x, y: x != y,
    '==': lambda x, y: x == y,
    '<=': lambda x, y: x <= y,
    '<': lambda x, y: x < y,
    '>': lambda x, y: x > y
}

operations = {
    'inc': lambda x, y: x + y,
    'dec': lambda x, y: x - y
}

def solve(input):
    for instruction in input:
        tokens = instruction.split(" ")

        token_to_modify = tokens[0]
        token_operation = tokens[1]
        token_new_value = int(tokens[2])
        token_condition_register = tokens[4]
        token_condition_comparator = tokens[5]
        token_condition_value = int(tokens[6])

        if comparators[token_condition_comparator](register[token_condition_register], token_condition_value):
            register[token_to_modify] = operations[token_operation](register[token_to_modify], token_new_value)

    return sorted(register.values())[-1]

if __name__ == '__main__':
    input = open('./input.txt', 'r').read().strip().split("\n")
    print("solution: {}".format(solve(input)))
