import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let lines = input
    .components(separatedBy: .newlines)

var scores: [Int] = []

var pairs: [Character: Character] = [
    "(": ")",
    "[": "]",
    "{": "}",
    "<": ">",
]

lines.forEach {
    var stack = Array<Character>()
    var didBreak = false

    char: for char in $0 {
        switch char {
        case "[", "(", "<", "{":
            stack.append(char)
        case "]":
            if stack.last != "[" {
                didBreak = true
                break char
            } else {
                stack.removeLast()
            }
        case ")":
            if stack.last != "(" {
                didBreak = true
                break char
            } else {
                stack.removeLast()
            }
        case ">":
            if stack.last != "<" {
                didBreak = true
                break char
            } else {
                stack.removeLast()
            }
        case "}":
            if stack.last != "{" {
                didBreak = true
                break char
            } else {
                stack.removeLast()
            }
        default:
            fatalError()
        }
    }

    if !didBreak, !stack.isEmpty {
        var score = 0
        stack.reversed().compactMap { pairs[$0] }.forEach { (c: Character) in
            score *= 5
            switch c {
            case ")":
                score += 1
            case "]":
                score += 2
            case "}":
                score += 3
            case ">":
                score += 4
            default:
                break
            }
        }
        scores.append(score)
    }
}

let count = scores.count
let sortedScores = scores.sorted()
sortedScores.enumerated().forEach { index, score in
    print(index, score)
}