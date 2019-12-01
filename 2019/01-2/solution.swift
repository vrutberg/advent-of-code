import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

func calculateFuel(mass: Int) -> Int {
    let fuel = (mass / 3) - 2

    guard fuel > 0 else {
        return 0
    }

    return fuel + calculateFuel(mass: fuel)
}

let result = input.split(separator: "\n")
    .compactMap { Int($0) }
    .map(calculateFuel)
    .reduce(0) { $0 + $1 }

print(result)
