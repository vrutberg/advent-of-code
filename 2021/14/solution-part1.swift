import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

// let input = """
// NNCB

// CH -> B
// HH -> N
// CB -> H
// NH -> C
// HB -> C
// HC -> B
// HN -> C
// NN -> C
// BH -> H
// NC -> B
// NB -> B
// BN -> B
// BB -> N
// BC -> B
// CC -> N
// CN -> C
// """

struct Pair: Hashable, Equatable {
    let a: Character
    let b: Character

    func inserting(_ character: Character) -> String {
        String([a, character, b])
    }
}

let lines = input
    .components(separatedBy: .newlines)

let template = lines.first!
let rules: [(Pair, Character)] = lines[2...].map {
    let split = $0.components(separatedBy: " -> ")
    return (Pair(a: split.first!.first!, b: split.first!.last!), split.last!.first!)
}
let rulesDictionary: [Pair: Character] = Dictionary(uniqueKeysWithValues: rules)

func apply(rules: [Pair: Character], to template: String) -> String {
    var newString = ""

    template.indices.forEach {
        guard $0 != template.indices.last else {
            return
        }

        let currentPair = Pair(a: template[$0], b: template[template.index(after: $0)])
        if let replacement = rules[currentPair] {
            newString.append(String([currentPair.a, replacement]))

            if $0 == template.index(before: template.indices.last!) {
                newString.append(currentPair.b)
            }
        } else {
            // ¯\_(ツ)_/¯ 
        }
    }

    return newString
}

var a = template
(0..<10).forEach { _ in
    a = apply(rules: rulesDictionary, to: a)
}
let counts = a.reduce(into: [:]) { $0[$1, default: 0] += 1 }.sorted { $0.value > $1.value }
let mostCommon = counts.first!.value
let leastCommon = counts.last!.value
let answer = mostCommon - leastCommon
print(answer)