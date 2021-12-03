import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}



let rows = input
    .components(separatedBy: .newlines)
    .map { Array($0).map { Int(String($0))! } }

var dict = [Int: (Int, Int)]()

(0..<rows[0].count).forEach {
    let column = $0

    rows.forEach { row in
        var value = dict[column, default: (0, 0)]
        if row[column] == 0 {
            value.0 += 1
        } else if row[column] == 1 {
            value.1 += 1
        }
        dict[column] = value
    }
}

let rawGamma = dict.keys.sorted().map {
    let value = dict[$0]!
    return value.0 > value.1 ? 0 : 1
}.map { (value: Int) -> String in "\(value)" }.joined()

let rawEpsilon = rawGamma.map {
    return $0 == "0" ? "1" : "0"
}.joined()

let gamma = Int(rawGamma, radix: 2)!
let epsilon = Int(rawEpsilon, radix: 2)!

print(gamma * epsilon)