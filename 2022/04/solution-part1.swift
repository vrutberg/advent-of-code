import Foundation

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

let lines = input
    .components(separatedBy: .newlines)
    .map {
        let split = $0.split(separator: ",")
        return split.map {
            $0
                .split(separator: "-")
                .map(String.init)
                .compactMap(Int.init)
        }
    }
    .filter { (pair: [[Int]]) -> Bool in
        (pair[0][0] >= pair[1][0]
            && pair[0][1] <= pair[1][1])
            || ( 
                pair[1][0] >= pair[0][0] 
                && pair[0][1] >= pair[1][1]
             )
    }

print(lines.count)