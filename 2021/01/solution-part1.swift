import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let numbers = input
    .split(separator: "\n")
    .compactMap { Int($0) }

var increased = 0
var previousNumber: Int?

numbers.forEach {
    if let previousNumber = previousNumber {
        if $0 > previousNumber {
            increased += 1
        }
    }

    previousNumber = $0
}

print(increased)