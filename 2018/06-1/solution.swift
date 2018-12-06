#!/usr/bin/swift

import Foundation

let start = Date()

struct Point: Hashable {
    let x: Int
    let y: Int
}

func isFinite(point: Point, in points: [Point]) -> Bool {
    guard points.contains(where: { $0.y < point.y }),
        points.contains(where: { $0.y > point.y }),
        points.contains(where: { $0.x < point.x }),
        points.contains(where: { $0.x > point.x }) else {
            return false
        }

    return true
}

func findClosestPath(point: Point, in points: [Point]) -> Int? {
    var lengths = [Int.max]
    var storedIndex = Int.max

    points.enumerated().forEach { index, p in
        let dx = abs(p.x - point.x)
        let dy = abs(p.y - point.y)

        if dx + dy <= (lengths.min()!) {
            lengths.append(dx + dy)
            storedIndex = index
        }
    }

    lengths.sort { $0 > $1 }
    if lengths.popLast()! == lengths.last! {
        return nil
    } else {
        return storedIndex
    }
}

let input = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .split(separator: "\n")
    .map(String.init)
    .map { (line: String) -> Point in
        let parts = line.split(separator: ",")
        let x = Int(parts[0])!
        let y = Int(String(parts[1]).trimmingCharacters(in: .whitespaces))!

        return Point(x: x, y: y)
    }

let minY = input.min { $0.y < $1.y }!.y
let maxY = input.max { $0.y < $1.y }!.y
let minX = input.min { $0.x < $1.x }!.x
let maxX = input.max { $0.x < $1.x }!.x

var s = [Point: Int]()

(minX...maxX).forEach { x in
    (minY...maxY).forEach { y in
        if let index = findClosestPath(point: Point(x: x, y: y), in: input),
            isFinite(point: input[index], in: input) {
            s[input[index], default: 0] += 1
        }
    }
}

print(s.max { $0.value < $1.value }!.value)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
