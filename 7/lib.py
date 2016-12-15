#!/usr/local/bin/python3

import re

class TLSDecider:
    @staticmethod
    def contains_palindrome(s: str):
        for index, value in enumerate(s):
            try:
                if value == s[index+1]:
                    return True
            except:
                continue

        return False

    @staticmethod
    def decide(s: str):
        parts = [s.split("[")[0]]
        parts += s.split("[")[1].split("]")

        return True if (TLSDecider.contains_palindrome(parts[0]) or TLSDecider.contains_palindrome(parts[2])) and not TLSDecider.contains_palindrome(parts[1]) else False
