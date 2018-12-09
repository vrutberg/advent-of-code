#!/usr/bin/swift

import Foundation

let start = Date()

let input = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
    .split(separator: " ")
    .map { return Int(String($0).trimmingCharacters(in: .whitespacesAndNewlines))! }

enum State {
    case childCount(Int)
    case metadataCount(Int)
    case metadataNode(Int)
}

var states = [State]()
var metadataCountLevels = [Int]()
var currentMetadataCount = 0

var childCountLevels = [Int]()
var currentChildCountLevels = [Int]()
var currentChildCount = 0

input.forEach {

    guard !states.isEmpty else {
        states.append(.childCount($0))
        return
    }

    // if last one was a child count, we know this one is always metadata count
    if case .childCount = states.last! {
        states.append(.metadataCount($0))
        metadataCountLevels.append($0)

    // if last one was metadata count, we have to figure out if this is
    // a child count for a child or a metadata node
    } else if case .metadataCount = states.last! {
        if case .childCount(let count) = states.last(where: {
            switch $0 {
            case .childCount: return true
            default: return false
            }
        })! {
            // there are children
            if count > 0 {
                childCountLevels.append(count)
                currentChildCountLevels.append(currentChildCount)
                currentChildCount = 0
                states.append(.childCount($0))

            // there are no children in this node, this is a metadata node
            } else {
                states.append(.metadataNode($0))
                currentMetadataCount = 1
            }
        }

    // if last one was a metadata node, we have to figure out if this is:
    // * another metadata node
    // * if the next child begins
    // * if this was
    // the last child and it's back to the parent
    } else if case .metadataNode = states.last! {

        // we're out of metadata nodes, node ends
        if metadataCountLevels.last == currentMetadataCount {
            currentMetadataCount = 0
            _ = metadataCountLevels.popLast()

            currentChildCount += 1

            if childCountLevels.last == currentChildCount {
                currentChildCount = currentChildCountLevels.popLast()!
                _ = childCountLevels.popLast()
                states.append(.metadataNode($0))
                currentMetadataCount = 1

            // there are more children in this parent
            } else {
                states.append(.childCount($0))
            }

        // this is a metadata node
        } else {
            states.append(.metadataNode($0))
            currentMetadataCount += 1
        }
    }
}

let result = states.reduce(0) {
    switch $1 {
    case .metadataNode(let count):
        return $0 + count
    default: return $0
    }
}

print(result)

let end = Date()
print("took: \(end.timeIntervalSince1970 - start.timeIntervalSince1970) seconds")
