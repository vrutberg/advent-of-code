#!/usr/bin/swift

import Foundation

let start = Date()

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

let guardIdRegex = try! NSRegularExpression(pattern: "#(\\d+)")

struct LogEntry {
    enum Event {
        case beginsShift(Int), fallsAsleep, wakesUp
    }

    let event: Event
    let date: Date

    init(from string: String) {
        let openingBrace = string.index(after: string.firstIndex(of: "[")!)
        let closingBrace = string.firstIndex(of: "]")!
        let dateString = String(string[openingBrace ..< closingBrace])
        let eventString = String(string[string.index(after: closingBrace)...]).trimmingCharacters(in: .whitespacesAndNewlines)

        self.date = dateFormatter.date(from: dateString)!

        if eventString.contains("begins shift") {
            let match = guardIdRegex.firstMatch(in: eventString, range: NSRange(eventString.startIndex..., in: eventString))!
            let guardId = Int(eventString[Range(match.range(at: 1), in: eventString)!])!

            self.event = .beginsShift(guardId)
        } else if eventString.contains("wakes up") {
            self.event = .wakesUp
        } else if eventString.contains("falls asleep") {
            self.event = .fallsAsleep
        } else {
            fatalError()
        }
    }
}

var storedGuardId: Int!
let calendar = Calendar.current
var fellAsleepDate: Date?
var minutesOfSleepPerGuard = [Int: [Int]]()

try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .split(separator: "\n")
    .map(String.init)
    .map(LogEntry.init)
    .sorted {
        $0.date < $1.date
    }
    .forEach {
        switch ($0.event) {
        case .beginsShift(let guardId):
            storedGuardId = guardId
        case .fallsAsleep:
            fellAsleepDate = $0.date
        case .wakesUp:
            let from = calendar.component(.minute, from: fellAsleepDate!)
            let to = calendar.component(.minute, from: $0.date)

            if minutesOfSleepPerGuard[storedGuardId] == nil {
                minutesOfSleepPerGuard[storedGuardId] = []
            }

            minutesOfSleepPerGuard[storedGuardId]! += Array(from ..< to)
        }
    }

var m = (key: 0, value: 0)
var g = 0

minutesOfSleepPerGuard.forEach { guardId, minutes in
    let mostCommonMinute = minutes.reduce(into: [:]) { $0[$1, default: 0] += 1 }
        .max { $0.1 < $1.1 }!

    if mostCommonMinute.value > m.value {
        m = mostCommonMinute
        g = guardId
    }
}

print(g * m.key)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
