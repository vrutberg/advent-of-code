import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

var lanternfish = input.split(separator: ",").map { Int($0)! }
var dict: [Int: Int] = Dictionary(lanternfish.map { ($0, 1) }, uniquingKeysWith: +)

(0..<256).forEach { _ in
    let zeroCount = dict[0, default: 0]

    dict = Dictionary(
        uniqueKeysWithValues: dict
            .filter { $0.key != 0 }
            .map { ($0.key - 1, $0.value) }
        )

    dict[8, default: 0] += zeroCount
    dict[6, default: 0] += zeroCount

}

print(dict.values.reduce(0, +))