import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let lines = input
    .components(separatedBy: .newlines)
    .flatMap { $0.split(separator: "|").last!.split(separator: " ") }

let answer = lines.filter { [2, 7, 4, 3].contains($0.count) }.count

print(answer)