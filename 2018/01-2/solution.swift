import Foundation

let start = Date()

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let changes = input.split(separator: "\n").compactMap { Int($0) }
var cursor = 0
var frequencies = Set<Int>()
var currentFrequency = 0

while !frequencies.contains(currentFrequency) {
    frequencies.insert(currentFrequency)
    currentFrequency += changes[cursor]
    cursor = (cursor == changes.count-1) ? 0 : cursor+1
}

print("result: \(currentFrequency)")

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
