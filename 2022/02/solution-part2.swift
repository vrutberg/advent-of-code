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

    func ownChoice(toAchieve result: GameResult) -> Choice {
        switch (result, self) {
        case (.draw, _): return self
        case (.win, .rock): return .paper
        case (.win, .paper): return .scissors
        case (.win, .scissors): return .rock
        case (.lose, .rock): return .scissors
        case (.lose, .paper): return .rock
        case (.lose, .scissors): return .paper
        }
    }
}

enum GameResult: String {
    case lose = "X"
    case draw = "Y"
    case win = "Z"
}

let answer = input
    .components(separatedBy: .newlines)
    .map { line in
        let split = line.split(separator: " ")
        let expectedResult = GameResult(rawValue: String(split[1]))!
        let opponentChoice = Choice(opponentChoice: String(split[0]))!
        let ownChoice = opponentChoice.ownChoice(toAchieve: expectedResult)

        return (opponentChoice, ownChoice)
    }
    .map { (opponentChoice: Choice, ownChoice: Choice) -> Int in
        ownChoice.ownChoiceScore + ownChoice.gameScore(opponentChoice: opponentChoice)
    }
    .reduce(0, +)

print(answer)