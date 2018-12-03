#!/usr/bin/swift

import Foundation

let start = Date()

let boxIds = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
  .split(separator: "\n")
  .map(String.init)

var wasFound = false

boxIds.forEach { element in
  boxIds.forEach { otherElement in
    guard !wasFound else {
      return
    }

    guard element != otherElement else {
      return
    }

    var characterEquality = [Bool]()

    zip(element, otherElement).forEach {
      characterEquality.append($0 == $1)
    }

    if (characterEquality.filter { !$0 }.count) == 1,
        let index = characterEquality.firstIndex(of: false) {
      var mutableElement = element
      mutableElement.remove(at: String.Index(encodedOffset: index))
      print(mutableElement)
      let end = Date()
      print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
      wasFound = true
    }
  }
}
