#!/usr/bin/swift

import Foundation

class Node {
    let value: Int

    private var previousNode: Node?
    private weak var nextNode: Node?

    var prev: Node {
        get {
            return previousNode ?? self
        }
        set {
            previousNode = newValue
        }
    }

    var next: Node {
        get {
            return nextNode ?? self
        }
        set {
            nextNode = newValue
        }
    }

    init(value: Int) {
        self.value = value
    }
}

class CyclicalLinkedList {
    var head: Node
    var tail: Node

    init(node: Node) {
        self.head = node
        self.tail = node
    }

    func append(node: Node, after: Node) -> Node {
        if after === tail {
            node.prev = tail
            node.next = head

            tail.next = node
            head.prev = node

            tail = node
        } else {
            node.prev = after
            node.next = after.next

            after.next.prev = node
            after.next = node
        }

        return node
    }

    func remove(node: Node) -> (next: Node, valueRemoved: Int) {
        if node === head {
            head = head.next
            tail.prev = head

            return (head.next, node.value)
        } else if node === tail {
            tail = tail.prev
            tail.next = head

            return (tail.next, node.value)
        } else {
            node.next.prev = node.prev
            node.prev.next = node.next

            return (node.next, node.value)
        }
    }
}

let start = Date()

let numberOfPlayers = 431
let lastMarble = 7095000

var players = [Int: Int]()
var marbleNode = Node(value: 0)
let list = CyclicalLinkedList(node: marbleNode)
var currentPlayer = 0

(1...lastMarble).forEach { marble in
    currentPlayer = (marble-1) % numberOfPlayers

    if marble % 23 == 0 {
        players[currentPlayer, default: 0] += marble
        let result = list.remove(node: marbleNode.prev.prev.prev.prev.prev.prev.prev)
        marbleNode = result.next
        players[currentPlayer, default: 0] += result.valueRemoved
        return
    }

    marbleNode = list.append(node: Node(value: marble), after: marbleNode.next)
}

print(players.max { $0.1 < $1.1 }!.value)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
