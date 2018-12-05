#!/usr/bin/swift

import Foundation

let start = Date()

let polymer = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .trimmingCharacters(in: .whitespacesAndNewlines)

let chars = "abcdefghijklmnopqrstuvwxyz"

let triggers = "abcdefghijklmnopqrstuvwxyz".map { (c: Character) -> String in
    [String(c), String(c).uppercased()].joined()
} +  "abcdefghijklmnopqrstuvwxyz".map { (c: Character) -> String in
    [String(c).uppercased(), String(c)].joined()
}

var shortest = Int.max

chars.forEach { t in
    var p = polymer

    p.removeAll { (c: Character) -> Bool in c == t || String(c) == String(t).uppercased() }

    while(true) {
        var performedAnyDeletions = false

        for trigger in triggers {
            if let range = p.range(of: trigger) {
                p.removeSubrange(range)
                performedAnyDeletions = true
            }
        }

        if !performedAnyDeletions {
            break
        }
    }

    if p.count < shortest {
        shortest = p.count
    }
}

print(shortest)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
