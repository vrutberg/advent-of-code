#!/usr/bin/swift

import Foundation

let start = Date()

extension String {
    func matches(for regex: NSRegularExpression) -> [NSTextCheckingResult] {
        return regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
    }

    func text(for match: NSTextCheckingResult, at position: Int = 1) -> String {
        return String(self[Range(match.range(at: position), in: self)!])
    }
}

let stepRegex = try! NSRegularExpression(pattern: "step ([A-Z])", options: [.caseInsensitive])

let prereqsByStep = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .split(separator: "\n")
    .map(String.init)
    .map { (string: String) -> (String, String) in
        let matches = string.matches(for: stepRegex)
        let prerequisite = string.text(for: matches[0])
        let step = string.text(for: matches[1])

        return (prerequisite, step)
    }
    .reduce(into: [:]) {
        $0[$1.1, default: Set<String>()].insert($1.0)
    }

let allSteps = prereqsByStep.reduce(into: Set<String>()) { memory, item in
    memory.insert(item.0)
    item.1.forEach { memory.insert($0) }
}

var startingNodes = allSteps.subtracting(prereqsByStep.compactMap { $0.0 }).sorted()
var steps = [String]()

func getNextStep(currentSteps: [String]) -> String? {
    var availableSteps = startingNodes.filter { !currentSteps.contains($0) }

    prereqsByStep.filter { !currentSteps.contains($0.0) }.forEach {
        if $1.subtracting(currentSteps).count == 0 {
            availableSteps.append($0)
        }
    }

    return availableSteps.sorted().first
}

while let nextStep = getNextStep(currentSteps: steps) {
    steps.append(nextStep)
}

print(steps.joined())

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
