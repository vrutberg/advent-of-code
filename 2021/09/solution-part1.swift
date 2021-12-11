import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

// struct Point {
//     let x: Int
//     let y: Int
//     let value: Int
// }

let map = input
    .components(separatedBy: .newlines)
    .map { 
        $0.map { Int(String($0))! }
    }

var risk = 0

map.enumerated().forEach { y, row in
    row.enumerated().forEach { x, value in
        let above = y > 0 ? map[y-1][x] : 10
        let below = y < map.count-1 ? map[y+1][x] : 10
        let left = x > 0 ? map[y][x-1] : 10
        let right = x < row.count-1 ? map[y][x+1] : 10

        if [above, below, left, right].allSatisfy({ $0 > value }) {
            risk += value + 1
        }
    }
}

print(risk)