#!/usr/local/bin/python3

from functools import reduce

def construct_knot_hash(input):
    input = [ord(x) for x in input]
    numbers = list(range(256))
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

def d2b(d):
    return ''.join([format(int(s, 32), 'b').zfill(4) for s in d])

def solve(input):
    hashes = [construct_knot_hash("{}-{}".format(input, i)) for i in range(128)]

    print(hashes)

    rows = ''.join([d2b(n) for n in hashes])

    print(rows)

    return len(list(filter(lambda x: x == '1', ''.join(rows))))

if __name__ == '__main__':
    input = "amgozmfv"
    print("solution: {}".format(solve(input)))
