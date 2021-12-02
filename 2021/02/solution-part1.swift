import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

enum Instruction {
    case down(Int)
    case forward(Int)
    case up(Int)

    init(string: String) {
        let split = Array(string.split(separator: " "))
        let value = Int(split[1])!

        switch split[0] {
        case "forward":
            self = .forward(value)
        case "down":
            self = .down(value)
        case "up":
            self = .up(value)
        default:
            fatalError()
        }
    }
}

var depth = 0
var horizontal = 0

input
    .components(separatedBy: .newlines)
    .map(Instruction.init)
    .forEach {
        switch $0 {
        case .down(let value):
            depth += value
        case .forward(let value):
            horizontal += value
        case .up(let value):
            depth -= value
        }
    }

let answer = depth * horizontal
print(answer)