import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

struct Coordinate: Equatable, Hashable {
    let x: Int
    let y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    init(string: String) {
        let split = string.split(separator: ",")
        self.x = Int(String(split.first!))!
        self.y = Int(String(split.last!))!
    }
}

enum Fold: Equatable, Hashable {
    case up(Int)
    case left(Int)

    init(string: String) {
        let interestingPart = String(string.components(separatedBy: "along ").last!)
        let split = interestingPart.split(separator: "=")
        let value = Int(String(split.last!))!
        switch split.first! {
        case "x":
            self = .left(value)
        case "y":
            self = .up(value)
        default:
            fatalError("unrecognized fold direction")
        }
    }
}

var dots = Set<Coordinate>()
var folds = [Fold]()

input
    .components(separatedBy: .newlines)
    .forEach {
        if $0.contains(",") {
            dots.insert(Coordinate(string: $0))
        } else if $0.contains("fold") {
            folds.append(Fold(string: $0))
        }
    }

func fold(
    dots: Set<Coordinate>,
    fold: Fold
) -> Set<Coordinate> {
    var result = Set<Coordinate>()

    dots.forEach { dot in
        switch fold {
        case .up(let foldPoint):
            if dot.y > foldPoint {
                let delta = dot.y - foldPoint
                result.insert(Coordinate(x: dot.x, y: dot.y - delta * 2))
            } else {
                result.insert(dot)
            }
        case .left(let foldPoint):
            if dot.x > foldPoint {
                let delta = dot.x - foldPoint
                result.insert(Coordinate(x: dot.x - delta * 2, y: dot.y))
            } else {
                result.insert(dot)
            }
        }
    }

    return result
}

let answer = fold(dots: dots, fold: folds.first!).count
print(answer)