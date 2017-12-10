#!/usr/local/bin/python3

def solve(length, input):
    numbers = list(range(length))
    cursor = 0
    skip_size = 0

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

    return numbers[0] * numbers[1]

if __name__ == '__main__':
    input = [int(str) for str in open('./input.txt', 'r').read().strip().split(",")]
    print("solution: {}".format(solve(256, input)))
