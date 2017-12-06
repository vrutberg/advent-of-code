#!/usr/local/bin/python3

seen = list()

def redistribute(index, values):
    iterations = values[index]
    values[index] = 0

    for i in range(index + 1, iterations + index + 1):
        values[i % len(values)] += 1

    return values

def find_max_index(input):
    return input.index(sorted(input)[-1])

def hash(input):
    return ",".join(str(x) for x in input)

def has_seen(input):
    seen.append(hash(input))

def solve(input):
    has_seen(input)

    while True:
        index = find_max_index(input)
        input = redistribute(index, input)

        if hash(input) in seen:
            return len(seen) - seen.index(hash(input))

        has_seen(input)

if __name__ == '__main__':
    input = [int(str) for str in open('./input.txt', 'r').read().strip().split("\t")]
    print("solution: {}".format(solve(input)))
