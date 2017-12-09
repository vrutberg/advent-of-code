#!/usr/local/bin/python3

import re

node_regex = re.compile('(\w+?)\s\((\d+)?\)')
children_regex = re.compile('-> (.+)')
nodes = list()

class Node:
    children = []

    def __init__(self, name, weight):
        self.name = name
        self.weight = weight

def weight_for_node(node):
    if len(node.children) == 0:
        return node.weight

    return node.weight + sum([weight_for_node(n) for n in node.children])

def solve(input):
    for row in input:
        match = node_regex.search(row)
        node = Node(match.group(1), int(match.group(2)))

        if '->' in row: # has children
            node.children = [s.strip() for s in children_regex.search(row).group(1).split(",")]

        nodes.append(node)

    for node in nodes:
        if len(node.children) > 0:
            node.children = list(filter(lambda x: x.name in node.children, nodes))

    top_nodes = set()
    child_nodes = set()

    for index, node in enumerate(nodes):
        top_nodes.add(node)

        for child_node in node.children:
            child_nodes.add(child_node)

    root = list(top_nodes.difference(child_nodes))[0]

    print(root.name, weight_for_node(root))

    for node in root.children:
        print(node.name, node.weight, weight_for_node(node))

    print("---")

    for node in root.children[2].children[1].children:
        print(node.name, node.weight, weight_for_node(node))

    return 0

if __name__ == '__main__':
    input = open('./input.txt', 'r').read().strip().split("\n")
    print("solution: {}".format(solve(input)))
