#!/usr/local/bin/python3

def solve(input, needle):
    nodes = {}
    programs = set()

    for line in input:
        segments = line.split(" <-> ")
        value = int(segments[0])
        children = [int(i) for i in segments[1].split(", ")]
        nodes[value] = children

    programs.add(needle)

    def p(needle):
        programs.add(needle)

        for x in nodes[needle]:
            if x not in programs:
                p(x)

    p(needle)

    return len(programs)

if __name__ == '__main__':
    input = open('./input.txt', 'r').read().strip().split("\n")
    print("solution: {}".format(solve(input, 0)))
