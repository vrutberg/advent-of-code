import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

let lines = input
    .components(separatedBy: .newlines)
    .chunked(into: 3)
    .map { (groups: [String]) -> Set<Character> in
        return Set(groups[0])
            .intersection(Set(groups[1]))
            .intersection(Set(groups[2]))
    }
    .flatMap { (a: Set<Character>) -> [Int] in
        a.map {
            if $0 == $0.uppercased().first! {
                return Int($0.asciiValue! - 38)
            } else {
                return Int($0.asciiValue! - 96)
            }
        }
    }
    .reduce(0, +)

print(lines)