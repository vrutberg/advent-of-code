#!/usr/local/bin/python3

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

    dense_hash = []

    for i in range(16):
        myslice = numbers[16*i:16*(i+1)]
        dense_hash.append(myslice[0] ^ myslice[1] ^ myslice[2] ^ myslice[3] ^ myslice[4] ^ myslice[5] ^ myslice[6] ^ myslice[7] ^ myslice[8] ^ myslice[9] ^ myslice[10] ^ myslice[11] ^ myslice[12] ^ myslice[13] ^ myslice[14] ^ myslice[15])

    hex_string = ""

    for i in dense_hash:
        i_hex = format(i, 'x')

        if len(i_hex) == 1:
            hex_string += '0' + i_hex
        else:
            hex_string += i_hex

    return hex_string

if __name__ == '__main__':
    input = calculate_input(open('./input.txt', 'r').read().strip())
    print("solution: {}".format(solve(256, input)))
