#!/usr/bin/swift

import Foundation

let start = Date()

let checksum = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
  .split(separator: "\n").map(String.init)
  .map { (boxId: String) -> [Character: Int] in
    return boxId.reduce([Character: Int]()) {
      var mutableCopy = $0

      if let count = mutableCopy[$1] {
        mutableCopy[$1] = count + 1
      } else {
        mutableCopy[$1] = 1
      }

      return mutableCopy
    }
  }
  .map { (charMap: [Character: Int]) -> (Int, Int) in
    return (charMap.contains { _, value in return value == 2 } ? 1 : 0,
            charMap.contains { _, value in return value == 3 } ? 1 : 0)
  }
  .reduce((0, 0)) { ($0.0 + $1.0, $0.1 + $1.1) }

print("result: \(checksum.0 * checksum.1)")

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
