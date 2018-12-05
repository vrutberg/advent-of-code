#!/usr/bin/swift

import Foundation

let start = Date()

var polymer = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .trimmingCharacters(in: .whitespacesAndNewlines)

let triggers = "abcdefghijklmnopqrstuvwxyz".map { (c: Character) -> String in
    [String(c), String(c).uppercased()].joined()
} +  "abcdefghijklmnopqrstuvwxyz".map { (c: Character) -> String in
    [String(c).uppercased(), String(c)].joined()
}

while(true) {
    var performedAnyDeletions = false

    for trigger in triggers {
        if let range = polymer.range(of: trigger) {
            polymer.removeSubrange(range)
            performedAnyDeletions = true
        }
    }

    if !performedAnyDeletions {
        break
    }
}

print(polymer.count / 2)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
