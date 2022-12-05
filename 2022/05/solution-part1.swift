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

input
    .components(separatedBy: .newlines)
    .map { (line: String) -> [Int] in
        line.split(separator: " ").compactMap { Int($0) }
    }
    .forEach { (instruction: [Int]) in
        (0..<instruction[0]).forEach { _ in
            if let last = stacks[instruction[1]-1].popLast() {
                stacks[instruction[2]-1].append(last)
            }
        }
    }

let last = stacks.compactMap { $0.last }.map(String.init).joined()
print(last)