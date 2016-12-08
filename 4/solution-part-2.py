#!/usr/local/bin/python3

from lib import *

if __name__ == '__main__':

    input = open('input.txt', 'r').read().strip().split('\n')

    decrypter = RoomNameDecrypter()

    for room_string in input:
        room = Room(room_string)
        print("{}: {}".format(decrypter.decrypt(room), room.sector_id))
