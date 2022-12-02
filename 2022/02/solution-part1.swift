import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

enum Choice {
    case rock, paper, scissors

    init?(opponentChoice: String) {
        switch opponentChoice {
        case "A": self = .rock
        case "B": self = .paper
        case "C": self = .scissors
        default: return nil
        }
    }

    init?(ownChoice: String) {
        switch ownChoice {
        case "X": self = .rock
        case "Y": self = .paper
        case "Z": self = .scissors
        default: return nil
        }
    }

    var ownChoiceScore: Int {
        switch self {
        case .rock: return 1
        case .paper: return 2
        case .scissors: return 3
        }
    }

    func gameScore(opponentChoice: Choice) -> Int {
        switch (opponentChoice, self) {
            case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
                return 3
            case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
                return 0
            case (.scissors, .rock), (.rock, .paper), (.paper, .scissors):
                return 6
        }
    }
}

let answer = input
    .components(separatedBy: .newlines)
    .map { line in
        let split = line.split(separator: " ")
        return (
            Choice(opponentChoice: String(split[0]))!,
            Choice(ownChoice: String(split[1]))!
        )
    }
    .map { opponentChoice, ownChoice in
        ownChoice.ownChoiceScore + ownChoice.gameScore(opponentChoice: opponentChoice)
    }
    .reduce(0, +)

print(answer)