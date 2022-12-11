import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

var currentIteration = 14
var windowStart = input.startIndex
var windowEnd = input.index(input.startIndex, offsetBy: 14)
var c = Set<Substring.Element>()

while c.count != 14 {
    let substring = input[windowStart..<windowEnd]
    print(currentIteration, substring)
    c = Set(substring)
    windowStart = input.index(windowStart, offsetBy: 1)
    windowEnd = input.index(windowEnd, offsetBy: 1)
    currentIteration += 1
}

print(currentIteration-1)
