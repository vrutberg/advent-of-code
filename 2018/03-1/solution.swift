#!/usr/bin/swift

import Foundation

let start = Date()

struct Claim {
    let x: Int
    let y: Int
    let width: Int
    let height: Int

    private static let regex = try! NSRegularExpression(pattern: "(\\d+),(\\d+): (\\d+)x(\\d+)")

    init(from string: String) {
        guard let match = Claim.regex.firstMatch(in: string, range: NSRange(string.startIndex..., in: string)) else {
            fatalError()
        }

        self.x = Int(string[Range(match.range(at: 1), in: string)!])!
        self.y = Int(string[Range(match.range(at: 2), in: string)!])!
        self.width = Int(string[Range(match.range(at: 3), in: string)!])!
        self.height = Int(string[Range(match.range(at: 4), in: string)!])!
    }
}

var fabric = [[Int]](repeating: [Int](repeating: 0, count: 1000), count: 1000)

try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .split(separator: "\n")
    .map(String.init)
    .map(Claim.init)
    .forEach { claim in
        (claim.x ..< claim.x + claim.width).forEach { x in
            (claim.y ..< claim.y + claim.height).forEach { y in
                fabric[x][y] += 1
            }
        }
    }

let result = fabric.flatMap { (row: [Int]) -> [Bool] in return row.map { $0 > 1 } }
    .filter { $0 }
    .count

print(result)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
