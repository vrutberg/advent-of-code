import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let rows = input
    .components(separatedBy: .newlines)
    .map { Array($0).map { Int(String($0))! } }

enum Criteria { case more, less }

func filter(rows: [[Int]], criteria: Criteria, position: Int = 0) -> [[Int]] {
    guard rows.count > 1 else {
        return rows
    }

    var rowsToKeep: [[Int]] = []
    var numbers = (0, 0)

    rows.map { $0[position] }.forEach { num in
        if num == 0 {
            numbers.0 += 1
        } else {
            numbers.1 += 1
        }
    }

    switch criteria {
    case .less:
        if numbers.0 > numbers.1 {
            rowsToKeep = rows.filter { $0[position] == 0 }
        } else {
            rowsToKeep = rows.filter { $0[position] == 1 }
        }
    case .more:
        if numbers.0 <= numbers.1 {
            rowsToKeep = rows.filter { $0[position] == 0 }
        } else {
            rowsToKeep = rows.filter { $0[position] == 1 }
        }
    }

    return filter(rows: rowsToKeep, criteria: criteria, position: position+1)
}

let oxygenGeneratorRating = filter(rows: rows, criteria: .more).first!.map { "\($0)" }.joined()
let co2ScrubberRating = filter(rows: rows, criteria: .less).first!.map { "\($0)" }.joined()

print(Int(oxygenGeneratorRating, radix: 2)! * Int(co2ScrubberRating, radix: 2)!)