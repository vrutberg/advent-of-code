import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let numbers = input
    .components(separatedBy: .newlines)
    .compactMap { Int($0) }

var increased = 0

numbers.enumerated().forEach { index, number in
    guard index >= 1 else {
        return
    }

    if number > numbers[index-1] {
        increased += 1
    }
}

print(increased)