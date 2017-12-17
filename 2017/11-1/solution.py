#!/usr/local/bin/python3

bump_ne_nw = False

def n(x, y):
    return (x, y+1)

def s(x, y):
    return (x, y-1)

def ne(x, y):
    if bump_ne_nw:
        return (x+1, y+1)
    else:
        return (x+1, y)

def nw(x, y):
    if bump_ne_nw:
        return (x-1, y+1)
    else:
        return (x-1, y)

def se(x, y):
    if not bump_ne_nw:
        return (x+1, y-1)
    else:
        return (x+1, y)

def sw(x, y):
    if not bump_ne_nw:
        return (x-1, y-1)
    else:
        return (x-1, y)

ops = {
    'n' : n,
    's' : s,
    'ne': ne,
    'nw': nw,
    'sw': sw,
    'se': se,
}

def navigate(input):
    global bump_ne_nw

    bump_ne_nw = False

    x, y = (0, 0)

    for i in input:
        x, y = ops[i](x, y)

        if not i in ['s', 'n']:
            bump_ne_nw = not bump_ne_nw

    return (x, y)

def calculate_direction(source, target, bump_ne_nw):
    print("source: {}, target: {}, bump_ne_nw: {}".format(source, target, bump_ne_nw))
    x, y = source
    targetX, targetY = target

    direction = None

    if targetX > x and (targetY > y or (targetY == y and not bump_ne_nw)):
        direction = 'ne'

    elif targetX > x and (targetY < y or (targetY == y and bump_ne_nw)):
        direction = 'se'

    elif targetX < x and (targetY > y or (targetY == y and not bump_ne_nw)):
        direction = 'nw'

    elif targetX < x and (targetY < y or (targetY == y and bump_ne_nw)):
        direction = 'sw'

    elif targetX == x and targetY > y:
        direction = 'n'

    elif targetX == x and targetY < y:
        direction = 's'

    return direction

def steps(source, target):
    global bump_ne_nw

    x, y = source
    targetX, targetY = target

    bump_ne_nw = False

    direction = calculate_direction((x, y), (targetX, targetY), bump_ne_nw)

    print('direction: {}'.format(direction))
    print('targetX: {}, targetY: {}'.format(targetX, targetY))
    print("x: {}, y: {}".format(x, y))

    steps = 0

    while direction is not None:
        print("stepping {}".format(direction))
        x, y = ops[direction](x, y)
        print("x: {}, y: {}".format(x, y))
        steps += 1

        if not direction in ['s', 'n']:
            bump_ne_nw = not bump_ne_nw

        direction = calculate_direction((x, y), (targetX, targetY), bump_ne_nw)

    print("x: {}, y: {}".format(targetX, targetY))

    return steps

def solve(input):
    return steps((0, 0), navigate(input))

if __name__ == '__main__':
    input = open('./input.txt', 'r').read().strip().split(",")
    print("solution: {}".format(solve(input)))
