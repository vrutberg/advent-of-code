#!/usr/local/bin/python3

def p(nodes, needle, programs):
    programs.add(needle)

    for x in nodes[needle]:
        if x not in programs:
            p(nodes, x, programs)

    return programs

def solve(input):
    nodes = {}
    programs = set()

    for line in input:
        segments = line.split(" <-> ")
        value = int(segments[0])
        children = [int(i) for i in segments[1].split(", ")]
        nodes[value] = children

    groups = set()

    for node in nodes:
        if not any(node in group for group in groups):
            groups.add(frozenset(p(nodes, node, set())))

    return len(groups)

if __name__ == '__main__':
    input = open('./input.txt', 'r').read().strip().split("\n")
    print("solution: {}".format(solve(input)))
