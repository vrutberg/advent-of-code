import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

final class Board {
    struct Coordinate: Hashable, Equatable {
        let row: Int
        let column: Int
    }

    let numbers: [[Int]]
    var markedCoordinates: Set<Coordinate> = []

    init(rows: [String]) {
        self.numbers = rows
            .map {
                $0.split(separator: " ")
                    .map {
                        Int($0.trimmingCharacters(in: .whitespacesAndNewlines))!
                    }
            }
    }

    func mark(number numberToMark: Int) {
        for (row, rowNumbers) in numbers.enumerated() {
            for (column, number) in rowNumbers.enumerated() {
                if numberToMark == number {
                    markedCoordinates.insert(Coordinate(row: row, column: column))
                }
            }
        }
    }

    func hasBingo() -> Bool {
        let rows = markedCoordinates.map { ($0.row, 1) }
        let rowCounts = Dictionary(rows, uniquingKeysWith: +)
        let columns = markedCoordinates.map { ($0.column, 1) }
        let columnCounts = Dictionary(columns, uniquingKeysWith: +)

        return rowCounts.values.sorted().last ?? 0 >= 5 || columnCounts.values.sorted().last ?? 0 >= 5
    }

    func score(lastNumber: Int) -> Int {
        var sum = 0
        for (row, rowNumbers) in numbers.enumerated() {
            for (column, number) in rowNumbers.enumerated() {
                if !markedCoordinates.contains(Coordinate(row: row, column: column)) {
                    sum += number
                }
            }
        }
        return sum * lastNumber
    }
}

let lines = input
    .components(separatedBy: "\n\n")

let numbers = lines[0].components(separatedBy: ",").map { Int($0)! }
let boards = lines[1...].map { Board(rows: $0.components(separatedBy: "\n")) }

var answer = -1

outerLoop: for number in numbers {
    for board in boards {
        board.mark(number: number)
        
        if board.hasBingo() {
            answer = board.score(lastNumber: number)
            break outerLoop
        }
    }
}

print(answer)
