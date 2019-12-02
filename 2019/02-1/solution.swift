import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

enum OpCode: Int {
    case add = 1
    case multiply = 2
    case halt = 99
}

var cursor = 0
var register = input.split(separator: ",").compactMap { Int($0) }
var currentOperation = OpCode(rawValue: register[cursor])!

while (currentOperation != .halt) {

    let firstIndex = register[cursor+1]
    let secondIndex = register[cursor+2]
    let replacingIndex = register[cursor+3]

    switch currentOperation {
    case .add:
        register[replacingIndex] = register[firstIndex] + register[secondIndex]

    case .multiply:
        register[replacingIndex] = register[firstIndex] * register[secondIndex]

    case .halt:
        fatalError()
    }

    cursor += 4
    currentOperation = OpCode(rawValue: register[cursor])!
}

print(register[0])
