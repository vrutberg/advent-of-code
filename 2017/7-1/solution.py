#!/usr/local/bin/python3

def solve(input):
    top_nodes = set()
    child_nodes = set()

    for row in input:
        if "->" in row:
            segments = [s.strip() for s in row.split("->")]
            top_nodes.add(segments[0].split(" ")[0])

            for child_node in [s.strip() for s in segments[1].split(",")]:
                child_nodes.add(child_node)

        else:
            top_nodes.add(row.split(" ")[0])

    return top_nodes.difference(child_nodes)

if __name__ == '__main__':
    input = open('./input.txt', 'r').read().strip().split("\n")
    print("solution: {}".format(solve(input)))
