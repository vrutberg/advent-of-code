#!/usr/bin/swift

import Foundation

let start = Date()

var compactedPolymer = ""

try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .enumerated()
    .forEach { index, char in
        guard index > 0 else {
            compactedPolymer.append(char)
            return
        }

        var didRemoveAnything = false

        if let lastChar = compactedPolymer.last {
            let uppercaseChar = Character(UnicodeScalar(char.unicodeScalars.first!.value - 32)!)
            let lowercaseChar = Character(UnicodeScalar(char.unicodeScalars.first!.value + 32)!)

            if lastChar == uppercaseChar || lastChar == lowercaseChar {
                _ = compactedPolymer.popLast()
                didRemoveAnything = true
            }
        }

        if !didRemoveAnything {
            compactedPolymer.append(char)
        }
    }

print(compactedPolymer.count)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
