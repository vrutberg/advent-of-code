import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let lines = input
    .components(separatedBy: .newlines)

var score = 0

lines.forEach {
    var stack = Array<Character>()

    char: for char in $0 {
        switch char {
        case "[", "(", "<", "{":
            stack.append(char)
        case "]":
            if stack.last != "[" {
                score += 57
                break char
            } else {
                stack.removeLast()
            }
        case ")":
            if stack.last != "(" {
                score += 3
                break char
            } else {
                stack.removeLast()
            }
        case ">":
            if stack.last != "<" {
                score += 25137
                break char
            } else {
                stack.removeLast()
            }
        case "}":
            if stack.last != "{" {
                score += 1197
                break char
            } else {
                stack.removeLast()
            }
        default:
            fatalError()
        }
    }
}

print(score)