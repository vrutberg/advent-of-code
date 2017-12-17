#!/usr/local/bin/python3

is_bump = False

def n(x, y):
    return (x, y+1)

def s(x, y):
    return (x, y-1)

def ne(x, y):
    if is_bump:
        return (x+1, y+1)
    else:
        return (x+1, y)

def nw(x, y):
    if is_bump:
        return (x-1, y+1)
    else:
        return (x-1, y)

def se(x, y):
    if not is_bump:
        return (x+1, y-1)
    else:
        return (x+1, y)

def sw(x, y):
    if not is_bump:
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
    global is_bump

    is_bump = False

    x, y = (0, 0)

    for i in input:
        x, y = ops[i](x, y)

        yield (x, y)

        if not i in ['s', 'n']:
            is_bump = not is_bump

def calculate_direction(source, target, is_bump):
    x, y = source
    targetX, targetY = target

    if targetX > x and (targetY > y or (targetY == y and not is_bump)):
        return 'ne'

    elif targetX > x and (targetY < y or (targetY == y and is_bump)):
        return 'se'

    elif targetX < x and (targetY > y or (targetY == y and not is_bump)):
        return 'nw'

    elif targetX < x and (targetY < y or (targetY == y and is_bump)):
        return 'sw'

    elif targetX == x and targetY > y:
        return 'n'

    elif targetX == x and targetY < y:
        return 's'

def steps(source, target):
    global is_bump

    x, y = source
    targetX, targetY = target

    is_bump = False

    direction = calculate_direction((x, y), (targetX, targetY), is_bump)
    steps = 0

    while direction is not None:
        x, y = ops[direction](x, y)
        steps += 1

        if not direction in ['s', 'n']:
            is_bump = not is_bump

        direction = calculate_direction((x, y), (targetX, targetY), is_bump)

    return steps

def solve(input):
    return max([steps((0, 0), i) for i in navigate(input)])

if __name__ == '__main__':
    input = open('./input.txt', 'r').read().strip().split(",")
    print("solution: {}".format(solve(input)))
