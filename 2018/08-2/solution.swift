#!/usr/bin/swift

import Foundation

let start = Date()

let input = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .split(separator: " ")
    .map { return Int(String($0).trimmingCharacters(in: .whitespacesAndNewlines))! }

func parse(data: [Int]) -> (metadataScore: Int, value: Int, data: [Int]) {
    var data = data

    let children = data[0]
    let numberOfMetadataEntries = data[1]

    data = Array(data[2...])

    var metadataScore = 0
    var value = [Int]()

    (0..<children).forEach { _ in
        let result = parse(data: data)
        data = result.data
        value.append(result.value)
        metadataScore += result.metadataScore
    }

    let metadataEntries = Array(data[..<numberOfMetadataEntries])
    metadataScore += metadataEntries.reduce(0) { $0 + $1 }

    if children == 0 {
        return (metadataScore, metadataScore, Array(data[numberOfMetadataEntries...]))
    } else {
        let childValues = metadataEntries.compactMap { (number) -> Int? in
            return (number-1 < value.count) ? value[number-1] : nil
        }.reduce(0) { $0 + $1 }

        return (metadataScore, childValues, Array(data[numberOfMetadataEntries...]))
    }
}

print(parse(data: input))

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
