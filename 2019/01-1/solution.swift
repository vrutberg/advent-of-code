import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let result = input.split(separator: "\n")
    .compactMap { Int($0) }
    .map { ($0 / 3) - 2 }
    .reduce(0) { $0 + $1 }

print(result)
