import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

var lanternfish = input.split(separator: ",").map { Int($0)! }

(0..<80).forEach { _ in
    var newLanternFish: [Int] = []

    lanternfish.forEach {
        if $0 == 0 {
            newLanternFish.append(6)
            newLanternFish.append(8)
        } else {
            newLanternFish.append($0-1)
        }
    }

    lanternfish = newLanternFish
}

print(lanternfish.count)