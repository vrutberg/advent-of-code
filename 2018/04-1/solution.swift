#!/usr/bin/swift

import Foundation

let start = Date()

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

let guardIdRegex = try! NSRegularExpression(pattern: "#(\\d+)")

struct LogEntry {
    enum Event {
        case beginsShift(Int)
        case fallsAsleep
        case wakesUp
    }

    let date: Date
    let event: Event

    init(from string: String) {
        let openingBrace = string.index(after: string.firstIndex(of: "[")!)
        let closingBrace = string.firstIndex(of: "]")!
        let dateString = String(string[openingBrace ..< closingBrace])
        let eventString = String(string[string.index(after: closingBrace)...]).trimmingCharacters(in: .whitespacesAndNewlines)

        if eventString.contains("begins shift") {
            let match = guardIdRegex.firstMatch(in: eventString, range: NSRange(eventString.startIndex..., in: eventString))!
            let guardId = Int(string[Range(match.range(at: 1), in: string)!])!

            self.event = .beginsShift(guardId)
        } else if eventString.contains("wakes up") {
            self.event = .wakesUp
        } else if eventString.contains("falls asleep") {
            self.event = .fallsAsleep
        } else {
            fatalError()
        }

        self.date = dateFormatter.date(from: dateString)!
    }
}

var minutesByGuard = [Int: Int]()

try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .split(separator: "\n")
    .map(String.init)
    .map(LogEntry.init)
    .sorted {
        $0.date < $1.date
    }
    .forEach {
        print($0)
    }

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
