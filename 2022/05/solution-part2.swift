import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}


// [H]                 [Z]         [J]
// [L]     [W] [B]     [G]         [R]
// [R]     [G] [S]     [J] [H]     [Q]
// [F]     [N] [T] [J] [P] [R]     [F]
// [B]     [C] [M] [R] [Q] [F] [G] [P]
// [C] [D] [F] [D] [D] [D] [T] [M] [G]
// [J] [C] [J] [J] [C] [L] [Z] [V] [B]
// [M] [Z] [H] [P] [N] [W] [P] [L] [C]
//  1   2   3   4   5   6   7   8   9 
 

var stacks = [
    Array("MJCBFRLH"),
    Array("ZCD"),
    Array("HJFCNGW"),
    Array("PJDMTSB"),
    Array("NCDRJ"),
    Array("WLDQPJGZ"),
    Array("PZTFRH"),
    Array("LVMG"),
    Array("CBGPFQRJ"),
]

extension Array {
    mutating func popLast(_ count: Int) -> Array<Element> {
        let toReturn = suffix(count)
        removeLast(count)
        return Array(toReturn)
    }
}

input
    .components(separatedBy: .newlines)
    .map { (line: String) -> [Int] in
        line.split(separator: " ").compactMap { Int($0) }
    }
    .forEach { (instruction: [Int]) in
        let elements = stacks[instruction[1]-1].popLast(instruction[0])
        stacks[instruction[2]-1].append(contentsOf: elements)
    }

let last = stacks.compactMap { $0.last }.map(String.init).joined()
print(last)