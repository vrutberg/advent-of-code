import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

enum OpCode: Int {
    case add = 1
    case multiply = 2
    case halt = 99
}

func runProgram(register: [Int]) -> Int {
    var mutableRegister = register
    var cursor = 0
    var currentOperation = OpCode(rawValue: mutableRegister[cursor])!

    while (currentOperation != .halt) {

        let firstIndex = mutableRegister[cursor+1]
        let secondIndex = mutableRegister[cursor+2]
        let replacingIndex = mutableRegister[cursor+3]

        switch currentOperation {
        case .add:
            mutableRegister[replacingIndex] = mutableRegister[firstIndex] + mutableRegister[secondIndex]

        case .multiply:
            mutableRegister[replacingIndex] = mutableRegister[firstIndex] * mutableRegister[secondIndex]

        case .halt:
            fatalError()
        }

        cursor += 4
        currentOperation = OpCode(rawValue: mutableRegister[cursor])!
    }

    return mutableRegister[0]
}

let initialRegister = input.split(separator: ",").compactMap { Int($0) }

(0...99).forEach { verb in
    (0...99).forEach { noun in
        var register = initialRegister
        register[1] = noun
        register[2] = verb

        let programResult = runProgram(register: register)

        if programResult == 19690720 {
            print("verb: \(verb)")
            print("noun: \(noun)")
            print("result: \(100 * noun + verb)")
        }
    }
}
