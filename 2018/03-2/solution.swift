#!/usr/bin/swift

import Foundation

let start = Date()

struct Claim {
    let id: Int
    let x: Int
    let y: Int
    let width: Int
    let height: Int

    private static let regex = try! NSRegularExpression(pattern: "#(\\d+) @ (\\d+),(\\d+): (\\d+)x(\\d+)")

    init(from string: String) {
        guard let match = Claim.regex.firstMatch(in: string, range: NSRange(string.startIndex..., in: string)) else {
            fatalError()
        }

        self.id = Int(string[Range(match.range(at: 1), in: string)!])!
        self.x = Int(string[Range(match.range(at: 2), in: string)!])!
        self.y = Int(string[Range(match.range(at: 3), in: string)!])!
        self.width = Int(string[Range(match.range(at: 4), in: string)!])!
        self.height = Int(string[Range(match.range(at: 5), in: string)!])!
    }
}

struct Coordinate: Hashable {
    let x: Int
    let y: Int
}

var claimIdsPerCoordinate = [Coordinate: [Int]]()
var overlaps = [Int: Set<Int>]()

try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .split(separator: "\n")
    .map(String.init)
    .map(Claim.init)
    .forEach { claim in
        overlaps[claim.id] = []

        (claim.x ..< claim.x + claim.width).forEach { x in
            (claim.y ..< claim.y + claim.height).forEach { y in
                let coordinate = Coordinate(x: x, y: y)

                if var ids = claimIdsPerCoordinate[coordinate] {
                    ids.forEach {
                        overlaps[claim.id]?.insert($0)
                        overlaps[$0]?.insert(claim.id)
                    }

                    ids.append(claim.id)
                    claimIdsPerCoordinate[coordinate] = ids
                } else {
                    claimIdsPerCoordinate[coordinate] = [claim.id]
                }
            }
        }
    }

let result = overlaps.filter { key, value in return value.count == 0 }

print(result)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
