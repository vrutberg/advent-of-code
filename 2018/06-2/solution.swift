#!/usr/bin/swift

import Foundation

let start = Date()

struct Point: Hashable {
    let x: Int
    let y: Int
}

func distanceBetween(point: Point, and otherPoint: Point) -> Int {
    let dx = abs(otherPoint.x - point.x)
    let dy = abs(otherPoint.y - point.y)

    return dx + dy
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

var size = 0

(minX...maxX).forEach { x in
    (minY...maxY).forEach { y in
        let p = Point(x: x, y: y)
        var sum = 0

        for point in input where sum < 10_000 {
            sum += distanceBetween(point: p, and: point)
        }

        if sum < 10_000 {
            size += 1
        }
    }
}

print(size)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
