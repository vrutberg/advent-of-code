#!/usr/local/bin/python3

import hashlib

class PasswordFinder:
    def __init__(self, input):
        self.input = input

    def find_password(self):
        password = ''
        current = 0

        while len(password) < 8:
            digest = hashlib.md5(str.encode('{}{}'.format(self.input, current))).hexdigest()

            if digest[:5] == '00000':
                print('found char {} for number {}'.format(digest[5], current))
                password += digest[5]

            current += 1

        return password


if __name__ == '__main__':
    print(PasswordFinder('abbhdwsy').find_password())
