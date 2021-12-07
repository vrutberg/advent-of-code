import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let numbers = input.split(separator: ",").map { Int($0)! }.sorted()
var dict: [Int: Int] = [:]

((numbers.first!)...(numbers.last!)).forEach { horizontalPosition in
    dict[horizontalPosition] = numbers.map {
        abs($0 - horizontalPosition)
    }.reduce(0, +)
}

print(dict.sorted(by: { $0.value < $1.value }).first!.value)
