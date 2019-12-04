import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

struct Position: Equatable, Hashable {
    var x: Int
    var y: Int
}

let wires = input.split(separator: "\n").map { $0.split(separator: ",") }
var wirePositions = [Set<Position>]()

wires.forEach { wire in
    var cursor = Position(x: 0, y: 0)
    var positions = Set<Position>()

    wire.forEach { instruction in
        let steps = Int(String(instruction.dropFirst()))!

        switch instruction.first! {
        case "L":
            (0..<steps).forEach { _ in
                cursor.x -= 1
                positions.insert(cursor)
            }
        case "R":
            (0..<steps).forEach { _ in
                cursor.x += 1
                positions.insert(cursor)
            }
        case "U":
            (0..<steps).forEach { _ in
                cursor.y += 1
                positions.insert(cursor)
            }
        case "D":
            (0..<steps).forEach { _ in
                cursor.y -= 1
                positions.insert(cursor)
            }
        default: break
        }
    }

    wirePositions.append(positions)
}

let intersections = wirePositions[0].intersection(wirePositions[1])
let result = intersections.map { abs($0.x) + abs($0.y) }.sorted().first!

print(result)
