import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

// let input = """
// $ cd /
// $ ls
// dir a
// 14848514 b.txt
// 8504156 c.dat
// dir d
// $ cd a
// $ ls
// dir e
// 29116 f
// 2557 g
// 62596 h.lst
// $ cd e
// $ ls
// 584 i
// $ cd ..
// $ cd ..
// $ cd d
// $ ls
// 4060174 j
// 8033020 d.log
// 5626152 d.ext
// 7214296 k
// """

final class File {
    let name: String
    let size: Int

    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
}

final class Directory: Equatable, Hashable {
    var files: [File] = []
    var directories: [Directory] = []
    var parent: Directory?
    let name: String

    init(parent: Directory? = nil, name: String) {
        self.parent = parent
        self.name = name
    }

    var size: Int {
        directories.map(\.size).reduce(0, +) + files.map(\.size).reduce(0, +)
    }

    var subdirectories: Set<Directory> {
        Set(directories.flatMap(\.directories))
    }

    func subdirectories(where predicate: (Directory) -> Bool) -> Set<Directory> {
        var subdirectories: Set<Directory> = Set(directories.flatMap {
            $0.subdirectories(where: predicate)
        })

        if predicate(self) {
            subdirectories.insert(self)
            return subdirectories
        } else {
            return subdirectories
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(parent)
        hasher.combine(name)
    }

    static func == (lhs: Directory, rhs: Directory) -> Bool {
        lhs.parent == rhs.parent && lhs.name == rhs.name
    }
}

struct Command {
    let input: String
    let output: [String]
}

var rootDirectory = Directory(name: "/")
var currentDirectory = rootDirectory

input
    .components(separatedBy: .newlines)
    .dropFirst()
    .forEach {
        let split = $0.split(separator: " ")
        if split[0] == "$" { // command
            if split[1] == "cd" {
                if split[2] == ".." {
                    currentDirectory = currentDirectory.parent!
                } else if split[2] == "/" {
                    currentDirectory = rootDirectory
                } else {
                    let newDirectory = Directory(parent: currentDirectory, name: String(split[2]))
                    currentDirectory.directories.append(newDirectory)
                    currentDirectory = newDirectory
                }
            }
        } else if let size = Int(String(split[0])) {
            currentDirectory.files.append(File(name: String(split[1]), size: size))
        }
    }

let size = rootDirectory.subdirectories(where: { $0.size >= 4965705 }).sorted(by: { $0.size < $1.size }).first!.size
print(size)