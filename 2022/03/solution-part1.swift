import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let lines = input
    .components(separatedBy: .newlines)
    .map {
        let middleIndex = $0.index($0.startIndex, offsetBy: $0.count/2)
        let firstHalf = String($0[..<middleIndex])
        let secondHalf = String($0[middleIndex...])

        return Set(firstHalf).intersection(Set(secondHalf))
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