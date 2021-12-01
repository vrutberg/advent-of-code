import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let numbers = input
    .components(separatedBy: .newlines)
    .compactMap { Int($0) }

let answer: Int = numbers
    .enumerated()
    .map { index, number in
        guard index >= 1 else {
            return 0
        }

        return number > numbers[index-1] ? 1 : 0
    }
    .reduce(0, +)

print(answer)