import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

final class Squid {
    var energy: Int
    var flashedDuringSteps: [Int] = []

    init(energy: Int) {
        self.energy = energy
    }
}

struct Coordinate: Hashable, Equatable {
    let x: Int
    let y: Int

    var surroundingCoordinates: [Coordinate] {
        [
            Coordinate(x: x-1, y: y-1),
            Coordinate(x: x-1, y: y),
            Coordinate(x: x-1, y: y+1),
            Coordinate(x: x, y: y-1),
            Coordinate(x: x, y: y+1),
            Coordinate(x: x+1, y: y-1),
            Coordinate(x: x+1, y: y),
            Coordinate(x: x+1, y: y+1),
        ]
    }
}

typealias Map = [[Squid]]

extension Map {
    func squid(at coordinate: Coordinate) -> Squid? {
        guard indices.contains(coordinate.y) else {
            return nil
        }

        guard self[coordinate.y].indices.contains(coordinate.x) else {
            return nil
        }

        return self[coordinate.y][coordinate.x]
    }

    func forEach(_ action: (Coordinate, Squid) -> Void) {
        enumerated().forEach { y, row in 
            row.enumerated().forEach { x, squid in
                action(Coordinate(x: x, y: y), squid)
            }
        }
    }

    func debugPrint() {
        enumerated().forEach { y, row in
            var line = ""
            row.enumerated().forEach { x, squid in
                line += "\(squid.energy) "
            }
            print(line)
        }
    }
}

func flashIfNecessary(squid: Squid, coordinate: Coordinate, map: Map, step: Int) -> Int {
    if squid.flashedDuringSteps.contains(step) {
        return 0
    }

    if squid.energy <= 9 {
        return 0
    }

    var flashes = 1
    squid.flashedDuringSteps.append(step)
    flashes += coordinate.surroundingCoordinates.compactMap {
        guard let s = map.squid(at: $0) else {
            return nil
        }

        return ($0, s)
    }.map { (c: Coordinate, neighbouringSquid: Squid) -> Int in
        neighbouringSquid.energy += 1
        return flashIfNecessary(squid: neighbouringSquid, coordinate: c, map: map, step: step)
    }.reduce(0, +)
    return flashes
}

let mapOfSquids: Map = input
    .components(separatedBy: .newlines)
    .map { $0.map { Int(String($0))! }.map(Squid.init) }

var step = 1
while true {
    mapOfSquids.forEach { _, squid in
        squid.energy += 1
    }

    mapOfSquids.forEach { coordinate, squid in
        _ = flashIfNecessary(squid: squid, coordinate: coordinate, map: mapOfSquids, step: step)
    }

    var numberOfFlashes = 0
    mapOfSquids.forEach { _, squid in
        if squid.flashedDuringSteps.contains(step) {
            numberOfFlashes += 1
            squid.energy = 0
        }
    }

    if numberOfFlashes == 100 {
        print(step)
        exit(0)
    }

    step += 1
}
