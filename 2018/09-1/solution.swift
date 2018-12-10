#!/usr/bin/swift

import Foundation

extension Array {
    func wrappedIndex(_ index: Int) -> Int {
        return ((index % count) + count) % count
    }
}

let start = Date()

let numberOfPlayers = 431
let lastMarble = 70950

var players = [Int: Int]()
var marbles = [Int]()
var currentPlayer = 0
var currentPosition = 0

(0...lastMarble).forEach { marble in
    if marble == 0 {
        marbles.append(marble)
        return
    }

    if marble == 1 {
        marbles.append(marble)
        currentPosition = 1
        return
    }

    currentPlayer = (marble-1) % numberOfPlayers

    if marble % 23 == 0 {
        players[currentPlayer, default: 0] += marble
        let removeAtIndex = marbles.wrappedIndex(currentPosition - 7)
        players[currentPlayer, default: 0] += marbles.remove(at: removeAtIndex)
        currentPosition = removeAtIndex
        return
    }

    var newPosition = currentPosition + 2
    if newPosition > marbles.count {
        newPosition = newPosition % marbles.count
    }

    marbles.insert(marble, at: newPosition)
    currentPosition = newPosition
}

print(players.max { $0.1 < $1.1 }!.value)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
