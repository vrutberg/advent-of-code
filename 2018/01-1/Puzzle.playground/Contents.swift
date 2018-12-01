import UIKit
import PlaygroundSupport

guard let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let input = try? String.init(contentsOf: fileUrl, encoding: .utf8)else {
    fatalError()
}

let result = input.split(separator: "\n")
    .compactMap { Int($0) }
    .reduce(0) { $0 + $1 }

print(result)
