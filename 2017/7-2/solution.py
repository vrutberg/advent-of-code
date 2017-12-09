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

    def total_weight(self):
        if len(self.children) == 0:
            return self.weight

        return self.weight + sum([n.total_weight() for n in self.children])

    def is_balanced(self):
        if len(self.children) == 0:
            return True

        weights = sorted([child.total_weight() for child in self.children])

        return weights[0] == weights[-1]


def find_root_node():
    top_nodes = set()
    child_nodes = set()

    for index, node in enumerate(nodes):
        top_nodes.add(node)

        for child_node in node.children:
            child_nodes.add(child_node)

    return list(top_nodes.difference(child_nodes))[0]

def find_unbalanced_node(node):
    for child in node.children:
        if not child.is_balanced():
            return find_unbalanced_node(child)

    weights = {}

    for child in node.children:
        t = child.total_weight()
        try:
            weights[t].append(child)
        except:
            weights[t] = [child]

    for key in weights.keys():
        value = weights[key]
        if len(value) == 1:
            sorted_keys = sorted(weights.keys())
            return value[0].weight - (sorted_keys[1] - sorted_keys[0])

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

    return find_unbalanced_node(find_root_node())

if __name__ == '__main__':
    input = open('./input.txt', 'r').read().strip().split("\n")
    print("solution: {}".format(solve(input)))
