import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

// let input = """
// 1163751742
// 1381373672
// 2136511328
// 3694931569
// 7463417111
// 1319128137
// 1359912421
// 3125421639
// 1293138521
// 2311944581
// """

struct Coordinate: Hashable, Equatable {
    let x: Int
    let y: Int

    var surroundingCoordinates: [Coordinate] {
        [
            // Coordinate(x: x-1, y: y-1),
            Coordinate(x: x-1, y: y),
            // Coordinate(x: x-1, y: y+1),
            Coordinate(x: x, y: y-1),
            Coordinate(x: x, y: y+1),
            // Coordinate(x: x+1, y: y-1),
            Coordinate(x: x+1, y: y),
            // Coordinate(x: x+1, y: y+1),
        ]
    }
}

typealias Map = [[Int]]

extension Map {
    func number(at coordinate: Coordinate) -> Int? {
        guard indices.contains(coordinate.y) else {
            return nil
        }

        guard self[coordinate.y].indices.contains(coordinate.x) else {
            return nil
        }

        return self[coordinate.y][coordinate.x]
    }
}

let lines = input
    .components(separatedBy: .newlines)
    .map { string -> [Int] in
        string.map {
            Int(String($0))!
        }
    }

func solve(
    map: [[Int]]
) -> Int {
    let source = Coordinate(x: 0, y: 0)
    let target = Coordinate(x: map.count-1, y: map.count-1)

    var distances: [Coordinate: Int] = [:]
    var unvisited = Set<Coordinate>()

    map.enumerated().forEach { y, row in
        row.enumerated().forEach { x, value in
            let c = Coordinate(x: x, y: y)
            distances[c] = Int.max
            unvisited.insert(c)
        }
    }

    distances[source] = 0
    
    while !unvisited.isEmpty {
        guard let current: Coordinate = unvisited.sorted(by: { (distances[$0] ?? Int.max) < (distances[$1] ?? Int.max) }).first else {
            fatalError("no more next node to visit")
        }

        unvisited.remove(current)

        if current == target {
            break
        }

        current.surroundingCoordinates.filter(unvisited.contains).forEach {
            guard let value = map.number(at: $0) else {
                fatalError("error horror")
            }
            let newDistance = (distances[current] ?? Int.max) + value

            if newDistance < (distances[$0] ?? Int.max) {
                distances[$0] = newDistance
            }
        }
    }
    
    return distances[target] ?? Int.max
}

let answer = solve(map: lines)
print(answer)