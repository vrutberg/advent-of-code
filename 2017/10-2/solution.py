#!/usr/local/bin/python3

from functools import reduce

def calculate_input(data):
    return [ord(str) for str in data] + [17, 31, 73, 47, 23]

def solve(length, input):
    numbers = list(range(length))
    cursor = 0
    skip_size = 0

    for round in range(64):
        for i in input:
            if i > 1:
                if cursor + i > len(numbers):
                    ending_segment = numbers[cursor:cursor + i] # at end of list
                    starting_segment = numbers[0:(cursor+i) % len(numbers)] # at start of list

                    whole = list(reversed(ending_segment + starting_segment))

                    numbers[cursor:cursor + i] = whole[0:len(ending_segment)]
                    numbers[0:(cursor+i) % len(numbers)] = whole[len(ending_segment):]
                else:
                    numbers[cursor:cursor+i] = list(reversed(numbers[cursor:cursor+i]))

            cursor = (cursor + i + skip_size) % len(numbers)
            skip_size += 1

    dense_hash = [reduce(lambda x, y: x ^ y, numbers[16*i:16*(i+1)], 0) for i in range(16)]
    return ''.join([format(i, 'x').zfill(2) for i in dense_hash])

if __name__ == '__main__':
    input = calculate_input(open('./input.txt', 'r').read().strip())
    print("solution: {}".format(solve(256, input)))
