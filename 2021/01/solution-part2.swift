import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

func sum(numbers: [Int], index: Int) -> Int{
    guard index >= 3 else {
        return 0
    }

    return numbers[index-2...index].reduce(0, +)
}

let numbers = input
    .components(separatedBy: .newlines)
    .compactMap { Int($0) }

let answer: Int = numbers
    .indices
    .map { index in
        (
            sum(numbers: numbers, index: index-1),
            sum(numbers: numbers, index: index)
        )
    }
    .map { $0.0 < $0.1 ? 1 : 0 }
    .reduce(0, +)

print(answer)