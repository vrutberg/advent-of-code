import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

// let input = """
// start-A
// start-b
// A-c
// A-b
// b-d
// A-end
// b-end
// """

let lines = input
    .components(separatedBy: .newlines)

final class Cave: Equatable, Hashable, CustomStringConvertible {
    enum Id: Equatable, Hashable, CustomStringConvertible {
        case big(String)
        case small(String)
        case start
        case end

        init(string: String) {
            switch string {
            case "start":
                self = .start
            case "end":
                self = .end
            case string where string == string.lowercased():
                self = .small(string)
            case string where string == string.uppercased():
                self = .big(string)
            default:
                fatalError("unsupported cave id")
            }
        }

        var comparator: Int {
            switch self {
            case .start: return 0
            case .end: return 1
            case .big(let name): return name.hashValue
            case .small(let name): return name.hashValue
            }
        }

        var description: String {
            switch self {
            case .start: return "start"
            case .end: return "end"
            case .big(let name): return "big(\(name))"
            case .small(let name): return "small(\(name))"
            }
        }
    }

    let id: Id
    var caves: Set<Cave>

    init(
        id: Id
    ) {
        self.id = id
        self.caves = []
    }

    func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }

    static func ==(lhs: Cave, rhs: Cave) -> Bool {
        lhs.id == rhs.id
    }

    var description: String {
        "\(id.description)<\(caves.map(\.id.description).joined(separator: ","))>"
    }
}

var caveSystem = Set<Cave>()

lines.forEach { line in
    let split = line.split(separator: "-")
    let source = Cave.Id(string: String(split[0]))
    let destination = Cave.Id(string: String(split[1]))

    let sourceCave: Cave
    if let s = caveSystem.first(where: { $0.id == source }) {
        sourceCave = s
    } else {
        sourceCave = Cave(id: source)
        caveSystem.insert(sourceCave)
    }

    let destinationCave: Cave
    if let d = caveSystem.first(where: { $0.id == destination }) {
        destinationCave = d
    } else {
        destinationCave = Cave(id: destination)
        caveSystem.insert(destinationCave)
    }

    sourceCave.caves.insert(destinationCave)
    destinationCave.caves.insert(sourceCave)
}

final class Node: CustomStringConvertible {
    let cave: Cave.Id
    var children: [Node]

    init(cave: Cave.Id, children: [Node]) {
        self.cave = cave
        self.children = children
    }

    func contains(_ caveId: Cave.Id) -> Bool {
        if cave == caveId {
            return true
        }

        return children.contains(where: { $0.contains(caveId) })
    }

    var description: String {
        var s = cave.description
        s += "<"
        children.forEach {
            s += $0.description
        }
        s += ">"
        return s
    }
}

func makeNode(
    cave: Cave,
    path: [Cave.Id]
) -> Node {
    var subNodes = [Node]()

    cave.caves.forEach {
        switch $0.id {
        case .small:
            if !path.contains($0.id) {
                subNodes.append(makeNode(cave: $0, path: path + [$0.id]))
            }
        case .big:
            subNodes.append(makeNode(cave: $0, path: path + [$0.id]))
        case .start:
            break
        case .end:
            subNodes.append(Node(cave: $0.id, children: []))
        }
    }

    return Node(cave: cave.id, children: subNodes)
}

let start = caveSystem.first { $0.id == .start }!

var paths = Set<[Cave.Id]>()
let root = makeNode(cave: start, path: [])

func getAllPaths(from root: Node) -> Set<[Cave.Id]> {
    var paths = Set<[Cave.Id]>()
    paths.insert([root.cave])
    
    root.children.forEach {
        let childPaths = getAllPaths(from: $0).map {
            [root.cave] + $0
        }
        paths.formUnion(childPaths)
    }

    return paths
}

let allPaths = getAllPaths(from: root).filter {
    $0.first == .start && $0.last == .end
}
let answer = allPaths.count
print(answer)
