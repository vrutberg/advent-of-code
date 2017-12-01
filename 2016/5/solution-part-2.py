#!/usr/local/bin/python3

import hashlib

class PasswordFinder:
    def __init__(self, input):
        self.input = input

    def find_password(self):
        password = ['_', '_', '_', '_', '_', '_', '_', '_']
        current = 0
        position = 8

        while '_' in password:
            digest = hashlib.md5(str.encode('{}{}'.format(self.input, current))).hexdigest()

            if digest[:5] == '00000':
                try:
                    position = int(digest[5])
                except:
                    position = 8

                if position < 8 and password[position] is '_':
                    print('placing character {} at position {}'.format(digest[6], position))
                    password[position] = digest[6]

            current += 1

        return "".join(password)


if __name__ == '__main__':
    print(PasswordFinder('abbhdwsy').find_password())
