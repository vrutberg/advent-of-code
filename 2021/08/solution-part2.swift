import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

struct Entry {
    let signalPatterns: [String]
    let output: [String]

    func solve() -> Int {
        let allCombinations: Set<Character> = ["a", "b", "c", "d", "e", "f", "g"]
        var top = allCombinations
        var topLeft = allCombinations
        var topRight = allCombinations
        var middle = allCombinations
        var bottom = allCombinations
        var bottomLeft = allCombinations
        var bottomRight = allCombinations

        if let one = signalPatterns.first(where: { $0.count == 2 }) {
            top.subtract(one)
            topLeft.subtract(one)
            topRight = topRight.intersection(one)
            middle.subtract(one)
            bottom.subtract(one)
            bottomLeft.subtract(one)
            bottomRight = bottomRight.intersection(one)
        }

        if let four = signalPatterns.first(where: { $0.count == 4 }) {
            top.subtract(four)
            topLeft = topLeft.intersection(four)
            topRight = topRight.intersection(four)
            middle = middle.intersection(four)
            bottom.subtract(four)
            bottomLeft.subtract(four)
            bottomRight = bottomRight.intersection(four)
        }

        if let seven = signalPatterns.first(where: { $0.count == 3 }) {
            top = top.intersection(seven)
            topLeft.subtract(seven)
            topRight = topRight.intersection(seven)
            middle.subtract(seven)
            bottom.subtract(seven)
            bottomLeft.subtract(seven)
            bottomRight = bottomRight.intersection(seven)
        }

        var spentNine = false
        var spentSix = false

        // 0, 6, or 9
        signalPatterns.filter { $0.count == 6 }.forEach {
            // 6
            if topRight.intersection($0).count == 1, !spentSix {
                top = top.intersection($0)
                topLeft = topLeft.intersection($0)
                topRight.subtract($0)
                middle = middle.intersection($0)
                bottom = bottom.intersection($0)
                bottomLeft = bottomLeft.intersection($0)
                bottomRight = bottomRight.intersection($0)

                spentSix = true
            }

            // 9
            else if bottomLeft.intersection($0).count == 1, !spentNine {
                top = top.intersection($0)
                topLeft = topLeft.intersection($0)
                topRight = topRight.intersection($0)
                middle = middle.intersection($0)
                bottom = bottom.intersection($0)
                bottomLeft.subtract($0)
                bottomRight = bottomRight.intersection($0)

                spentNine = true
            }

            // 0
            else {
                top = top.intersection($0)
                topLeft = topLeft.intersection($0)
                topRight = topRight.intersection($0)
                middle.subtract($0)
                bottom = bottom.intersection($0)
                bottomLeft = bottomLeft.intersection($0)
                bottomRight = bottomRight.intersection($0)
            }
        }

        let signals = [top.first!, topLeft.first!, topRight.first!, middle.first!, bottom.first!, bottomLeft.first!, bottomRight.first!]

        return output.map { outputDigit -> Int in
            let a = signals.indices.filter {
                outputDigit.contains(signals[$0])
            }

            switch a {
            case [2, 6]:
                return 1
            case [0, 2, 3, 4, 5]:
                return 2
            case [0, 2, 3, 4, 6]:
                return 3
            case [1, 2, 3, 6]:
                return 4
            case [0, 1, 3, 4, 6]:
                return 5
            case [0, 1, 3, 4, 5, 6]:
                return 6
            case [0, 2, 6]:
                return 7
            case [0, 1, 2, 3, 4, 5, 6]:
                return 8
            case [0, 1, 2, 3, 4, 6]:
                return 9
            case [0, 1, 2, 4, 5, 6]:
                return 0
            default:
                fatalError("LoL unknown number")
            }
        }
        .reduce(0, { $0 * 10 + $1})
    }
}

// let entry = Entry(signalPatterns: "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab".split(separator: " ").map(String.init), output: "cdfeb fcadb cdfeb cdbaf".split(separator: " ").map(String.init))
// print(entry.solve())

let entries: [Entry] = input
    .components(separatedBy: .newlines)
    .map { $0.split(separator: "|").map { $0.split(separator: " ").map(String.init) } }
    .map { Entry(signalPatterns: $0.first!, output: $0.last!) }

let answer = entries.map { $0.solve() }.map(String.init).map { Int($0)! }.reduce(0, +)
print(answer)