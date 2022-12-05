import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let lines = input
    .components(separatedBy: .newlines)
    .map {
        let split = $0.split(separator: ",")
        return split.map {
            $0
                .split(separator: "-")
                .map(String.init)
                .compactMap(Int.init)
        }
    }
    .filter { (pair: [[Int]]) -> Bool in
        let first = pair[0]
        let second = pair[1]

        let firstSet = Set(stride(from: first[0], through: first[1], by: 1))
        let secondSet = Set(stride(from: second[0], through: second[1], by: 1))

        return !firstSet.intersection(secondSet).isEmpty
    }

print(lines.count)