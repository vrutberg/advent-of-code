import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

// let input = """
// 2199943210
// 3987894921
// 9856789892
// 8767896789
// 9899965678
// """

extension Array where Element == [Int] {
    func value(coordinate: Coordinate) -> Int? {
        guard indices.contains(coordinate.y) else {
            return nil
        }

        guard self[coordinate.y].indices.contains(coordinate.x) else {
            return nil
        }

        return self[coordinate.y][coordinate.x]
    }
}

struct Coordinate: Hashable, Equatable {
    let x: Int
    let y: Int

    var below: Coordinate {
        Coordinate(x: x, y: y-1)
    }

    var above: Coordinate {
        Coordinate(x: x, y: y+1)
    }

    var left: Coordinate {
        Coordinate(x: x-1, y: y)
    }

    var right: Coordinate {
        Coordinate(x: x+1, y: y)
    }
}

let map = input
    .components(separatedBy: .newlines)
    .map { 
        $0.map { Int(String($0))! }
    }

func findBasin(
    map: [[Int]], 
    coordinate: Coordinate,
    visited: Set<Coordinate>
) -> Set<Coordinate> {
    var basinNeighbours = Set<Coordinate>()
    let value = map[coordinate.y][coordinate.x]
    var v = visited
    v.insert(coordinate)

    if let above = map.value(coordinate: coordinate.above), above < 9, above > value {
        basinNeighbours.insert(coordinate.above)
    }

    if let below = map.value(coordinate: coordinate.below), below < 9, below > value {
        basinNeighbours.insert(coordinate.below)
    }

    if let left = map.value(coordinate: coordinate.left), left < 9, left > value {
        basinNeighbours.insert(coordinate.left)
    }

    if let right = map.value(coordinate: coordinate.right), right < 9, right > value {
        basinNeighbours.insert(coordinate.right)
    }

    if basinNeighbours.isEmpty {
        return v
    }

    basinNeighbours.forEach {
        v.insert($0)
        v.formUnion(findBasin(map: map, coordinate: $0, visited: v))
    }

    return v
}

var lowPoints = Array<Coordinate>()

map.enumerated().forEach { y, row in
    row.enumerated().forEach { x, value in
        let coordinate = Coordinate(x: x, y: y)
        let above = y > 0 ? map[y-1][x] : 10
        let below = y < map.count-1 ? map[y+1][x] : 10
        let left = x > 0 ? map[y][x-1] : 10
        let right = x < row.count-1 ? map[y][x+1] : 10

        if [above, below, left, right].allSatisfy({ $0 > value }) {
            lowPoints.append(coordinate)
        }
    }
}

var basins: [Coordinate: Set<Coordinate>] = [:]

lowPoints.forEach { coordinate in
    basins[coordinate] = findBasin(map: map, coordinate: coordinate, visited: [])
}

// var allBasinCoordinates = Set(basins.values.flatMap { $0 })
// var html = ""
// map.enumerated().forEach { y, row in
//     row.enumerated().forEach { x, value in
//         let coordinate = Coordinate(x: x, y: y)

//         if lowPoints.contains(coordinate) {
//             html += "<span style=\"color: red\">\(value)</span>"
//         } else if allBasinCoordinates.contains(coordinate) {
//             html += "<span style=\"color: orange\">\(value)</span>"
//         } else {
//             html += "<span style=\"color: gray\">\(value)</span>"
//         }
//     }

//     html += "<br>\n"
// }

// print(html)

// print(basins.values.map(\.count))

let answer = basins.values.map(\.count).sorted().suffix(3).reduce(1, *)
print(answer)
