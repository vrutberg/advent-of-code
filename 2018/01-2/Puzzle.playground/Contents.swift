import UIKit
import PlaygroundSupport

guard let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let input = try? String.init(contentsOf: fileUrl, encoding: .utf8)else {
    fatalError()
}

let changes = input.split(separator: "\n").compactMap { Int($0) }
var cursor = 0
var frequencies = Set<Int>()
var currentFrequency = 0

while !frequencies.contains(currentFrequency) {
    frequencies.insert(currentFrequency)
    currentFrequency += changes[cursor]

    if cursor == changes.count-1 {
        cursor = 0
    } else {
        cursor += 1
    }
}

print(currentFrequency)
