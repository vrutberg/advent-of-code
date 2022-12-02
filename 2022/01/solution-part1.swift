import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let maxCalories = input
    .components(separatedBy: .newlines)
    .reduce(into: [Int]()) { result, line in
        if let calories = Int(line) {
            var last = result.popLast() ?? 0
            last += calories
            result.append(last)
        } else {
            result.append(0)
        }
    }
    .sorted(by: >)
    .first!

print(maxCalories)