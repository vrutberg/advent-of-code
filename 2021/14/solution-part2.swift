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

    func replacements(_ character: Character) -> [Pair] {
        [
            Pair(a: a, b: character),
            Pair(a: character, b: b)
        ]
    }
}

let lines = input
    .components(separatedBy: .newlines)

let template = lines.first!
let rules: [(Pair, Character)] = lines[2...].map {
    let split = $0.components(separatedBy: " -> ")
    return (Pair(a: split.first!.first!, b: split.first!.last!), split.last!.first!)
}

var pairs: [Pair: Int] = [:]
template.indices.forEach {
    guard $0 != template.indices.last else {
        return
    }

    let pair = Pair(a: template[$0], b: template[template.index(after: $0)])
    pairs[pair, default: 0] += 1
}

let rulesDictionary: [Pair: Character] = Dictionary(uniqueKeysWithValues: rules)

func apply(rules: [Pair: Character], to template: [Pair: Int]) -> [Pair: Int] {
    var copy = template

    template.keys.forEach { pair in
        if let character = rules[pair] {
            copy[pair]! -= template[pair]!

            pair.replacements(character).forEach {
                copy[$0, default: 0] += template[pair]!
            }
        }
    }

    return copy.filter { $0.value > 0 }
}

(0..<40).forEach { step in
    pairs = apply(rules: rulesDictionary, to: pairs)
}
let counts = pairs.reduce(into: [Character: Int]()) {
    $0[$1.key.a, default: 0] += $1.value
    $0[$1.key.b, default: 0] += $1.value
}.sorted { $0.value > $1.value }
print(counts)
let mostCommon = counts.first!.value
let leastCommon = counts.last!.value
let answer = mostCommon - leastCommon
print(answer / 2 + 1)