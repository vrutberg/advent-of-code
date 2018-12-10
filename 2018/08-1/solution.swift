#!/usr/bin/swift

import Foundation

let start = Date()

let input = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .split(separator: " ")
    .map { return Int(String($0).trimmingCharacters(in: .whitespacesAndNewlines))! }

func parse(data: [Int]) -> (metadataScore: Int, data: [Int]) {
    var data = data

    let children = data[0]
    let metadataEntries = data[1]

    data = Array(data[2...])

    var metadataScore = 0

    (0..<children).forEach { _ in
        let result = parse(data: data)
        data = result.data
        metadataScore += result.metadataScore
    }

    metadataScore += Array(data[..<metadataEntries]).reduce(0) { $0 + $1 }

    return (metadataScore, Array(data[metadataEntries...]))
}

print(parse(data: input))

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
