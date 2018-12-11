#!/usr/bin/swift

import Foundation

let start = Date()

extension String {
    func matches(for regex: NSRegularExpression) -> [NSTextCheckingResult] {
        return regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
    }

    func int(for match: NSTextCheckingResult, at position: Int = 1) -> Int {
        return Int(String(self[Range(match.range(at: position), in: self)!]))!
    }
}

class Instruction {
    var x: Int
    var y: Int

    let dx: Int
    let dy: Int

    init(x: Int, y: Int, dx: Int, dy: Int) {
        self.x = x
        self.y = y
        self.dx = dx
        self.dy = dy
    }
}

let numberRegex = try! NSRegularExpression(pattern: "(-?\\d+)", options: [.caseInsensitive])

let instructions = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .split(separator: "\n")
    .map(String.init)
    .map { (string: String) -> Instruction in
        let matches = string.matches(for: numberRegex)
        let x = string.int(for: matches[0])
        let y = string.int(for: matches[1])
        let dx = string.int(for: matches[2])
        let dy = string.int(for: matches[3])

        return Instruction(x: x, y: y, dx: dx, dy: dy)
    }

func paint(_ instructions: [Instruction]) -> String {
    var text = ""

    ((-120)...(-60)).reversed().forEach { y in
        var row = ""

        (100...300).forEach { x in
            if instructions.contains(where: { $0.x == x && $0.y == -y }) {
                row += "#"
            } else {
                row += "."
            }
        }

        text += row + "\n"
    }

    return text
}

func move() {
    instructions.forEach {
        $0.x += $0.dx
        $0.y += $0.dy
    }
}



(0...10_640).forEach { _ in
    move()
}

var count = 10_640

print("done")

while true {
    let painting = paint(instructions)

    if painting.contains("#") {
        print("count: \(count)")
        print(painting)
    }

    count += 1
    move()
}

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
