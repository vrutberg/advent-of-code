import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

var elvesAndCalories = [Int: Int]()

var cursor = 0
input
    .components(separatedBy: .newlines)
    .forEach { line in
        if let calories = Int(line) {
            elvesAndCalories[cursor, default: 0] += calories
        } else {
            cursor += 1
        }
    }

let calories = elvesAndCalories
    .sorted { $0.1 > $1.1 }
    .map(\.value)[0...2]
    .reduce(0, +)

print(calories)