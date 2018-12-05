#!/usr/bin/swift

import Foundation

let start = Date()

func compact(polymer: String) -> String {
    var compactedPolymer = ""

    polymer.enumerated().forEach { index, char in
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

    return compactedPolymer
}

let polymer = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .trimmingCharacters(in: .whitespacesAndNewlines)

let chars = "abcdefghijklmnopqrstuvwxyz"

var shortest = Int.max

chars.forEach { t in
    var p = polymer

    p.removeAll { (c: Character) -> Bool in c == t || String(c) == String(t).uppercased() }
    p = compact(polymer: p)

    if p.count < shortest {
        shortest = p.count
    }
}

print(shortest)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
