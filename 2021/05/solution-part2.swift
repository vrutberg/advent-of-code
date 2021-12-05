import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

struct Coordinate: Hashable, Equatable {
    let x: Int
    let y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    init(_ string: String) {
        let parts = string.split(separator: ",")
        self.x = Int(parts[0])!
        self.y = Int(parts[1])!
    }
}

struct Line {
    let start: Coordinate
    let end: Coordinate

    init(_ string: String) {
        let parts = string.components(separatedBy: " -> ")
        self.start = Coordinate(parts[0])
        self.end = Coordinate(parts[1])
    }

    var isStraight: Bool {
        return start.x == end.x || start.y == end.y
    }

    // 0,2 -> 2,0
    // 2,0 -> 0,2
    // 0,0 -> 2,2
    // 2,2 -> 0,0
    var isDiagonal: Bool {
        return abs(start.x - end.x) == abs(start.y - end.y)
    }

    var isVertical: Bool {
        return start.x == end.x
    }

    var coordinates: [Coordinate] {
        if isVertical {
            return stride(from: start.y, through: end.y, by: start.y < end.y ? 1 : -1).map { y in
                Coordinate(x: start.x, y: y)
            }
        } else if isDiagonal {
            let rangeX: StrideThrough<Int> = stride(from: start.x, through: end.x, by: start.x < end.x ? 1 : -1)
            let rangeY: StrideThrough<Int> = stride(from: start.y, through: end.y, by: start.y < end.y ? 1 : -1)

            return zip(rangeX, rangeY).map(Coordinate.init)
        } else {
            return stride(from: start.x, through: end.x, by: start.x < end.x ? 1 : -1).map { x in
                Coordinate(x: x, y: start.y)
            }
        }
    }
}

let lines = input
    .components(separatedBy: .newlines)
    .map(Line.init)

var coordinates: [Coordinate] = []

lines.forEach { line in
    coordinates.append(contentsOf: line.coordinates)
}

let coordinateCounts = Dictionary(coordinates.map { ($0, 1) }, uniquingKeysWith: +)
let answer = coordinateCounts.filter { $0.value > 1 }.count
print(answer)