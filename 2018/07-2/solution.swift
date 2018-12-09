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

    func absoluteIndex(of char: Character) -> Int {
        return self.distance(from: self.startIndex, to: self.index(of: char)!)
    }
}

let alphabet = "abcdefghijklmnopqrstuvwxyz".uppercased()
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

func getNextSteps(currentSteps: [String]) -> [String] {
    var availableSteps = startingNodes.filter { !currentSteps.contains($0) }

    prereqsByStep.filter { !currentSteps.contains($0.0) }.forEach {
        if $1.subtracting(currentSteps).count == 0 {
            availableSteps.append($0)
        }
    }

    return availableSteps.sorted()
}

class Worker {
    var work: String? = nil
    var timeLeft: Int = 0
}

var workers = [Worker]()

workers.append(Worker())
workers.append(Worker())
workers.append(Worker())
workers.append(Worker())
workers.append(Worker())

var counter = 0

while true {
    workers.enumerated().forEach { index, worker in
        print("Worker #\(index+1): work=\(worker.work ?? "-"), timeLeft=\(worker.timeLeft)")
    }

    workers.forEach { worker in
        if let work = worker.work {
            worker.timeLeft = max(0, worker.timeLeft - 1)

            if worker.timeLeft == 0 {
                worker.work = nil
                steps.append(work)
            }
        }
    }

    var nextSteps = getNextSteps(currentSteps: steps)
    if nextSteps.count == 0 {
        break
    }

    counter += 1

    nextSteps = nextSteps.filter { s in
        return !workers.contains { $0.work == s }
    }

    if nextSteps.count == 0 {
        print("no available steps, continuing")
        continue
    }

    print("assigning steps: \(nextSteps)")

    workers
        .filter { $0.work == nil }
        .forEach { worker in
            guard nextSteps.count > 0 else {
                return
            }

            print("assigning work \(nextSteps.first!)")

            worker.work = nextSteps.first!
            worker.timeLeft = alphabet.absoluteIndex(of: nextSteps.first!.first!) + 61
            nextSteps = nextSteps.filter { $0 != worker.work }
        }
}

print(counter)
print(steps.joined())

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
