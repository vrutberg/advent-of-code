import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let numbers = input.split(separator: ",").map { Int($0)! }

let sums: [Int] = numbers.indices.map { horizontalPosition -> Int in
    numbers.map { number -> Int in
        let steps: Int = abs(horizontalPosition - number)
        guard steps > 0 else { return 0 }

        var sum = 0
        var i = 1
        while i <= steps {
            sum += i
            i += 1
        }
        return sum
    }.reduce(0, +)
}

print(sums.sorted().first!)
