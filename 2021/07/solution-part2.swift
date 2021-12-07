import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let numbers = input.split(separator: ",").map { Int($0)! }.sorted()
var dict: [Int: Int] = [:]
var cache: [Int: Int] = [:]

((numbers.first!)...(numbers.last!)).forEach { horizontalPosition in
    dict[horizontalPosition] = numbers.map {
        let steps = abs(horizontalPosition - $0)
        if steps == 0 { return 0 }
        if steps == 1 { return 1 }

        if let cached = cache[steps] {
            return cached
        }

        let realSteps = (1...steps).reduce(0, +)
        cache[steps] = realSteps
        return realSteps
    }.reduce(0, +)
}

print(dict.sorted(by: { $0.value < $1.value }).first!.value)
