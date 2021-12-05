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

    var isVertical: Bool {
        return start.x == end.x
    }
}

let lines = input
    .components(separatedBy: .newlines)
    .map(Line.init)
    .filter(\.isStraight)

var coordinates: [Coordinate] = []

lines.forEach { line in
    if line.isVertical {
        let range: ClosedRange<Int> = line.start.y < line.end.y 
            ? line.start.y...line.end.y
            : line.end.y...line.start.y

        range.forEach { y in
            let x = line.start.x
            let coordinate = Coordinate(x: x, y: y)
            coordinates.append(coordinate)
        }
    } else {
        let range: ClosedRange<Int> = line.start.x < line.end.x
            ? line.start.x...line.end.x
            : line.end.x...line.start.x

        range.forEach { x in
            let y = line.start.y
            let coordinate = Coordinate(x: x, y: y)
            coordinates.append(coordinate)
        }
    }
}

let coordinateCounts = Dictionary(coordinates.map { ($0, 1) }, uniquingKeysWith: +)
let answer = coordinateCounts.filter { $0.value > 1 }.count
print(answer)

