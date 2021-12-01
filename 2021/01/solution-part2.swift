import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let numbers = input
    .split(separator: "\n")
    .compactMap { Int($0) }

var increased = 0
var previousGroup: Int?

numbers.enumerated().forEach { index, number in
    guard index >= 2 else {
        return
    }

    let currentGroup = numbers[index-2...index].reduce(0, +)

    if let previousGroup = previousGroup, currentGroup > previousGroup {
        increased += 1
    }

    previousGroup = currentGroup
}

print(increased)