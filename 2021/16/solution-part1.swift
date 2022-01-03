import Foundation

extension String {
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(self.suffix(toLength))
        }
    }
}

func parse(data: String) -> (Packet?, String) {
    if data.allSatisfy({ $0 == "0" }) {
        return (nil, data)
    }

    let version: Int = {
        let p = String(data.prefix(3))
        return Int(p, radix: 2) ?? -1
    }()

    var rest: String = ""

    let typeId: PacketTypeId = {
        let p = String(data.prefix(6).suffix(3))
        let value = Int(p, radix: 2)

        print("value", value)

        if value == 4 {
            let literalValue: Int = {
                var p = String(data.dropFirst(6))
                var binaryRepresentation = ""

                while true {
                    let next = p.prefix(5)
                    binaryRepresentation += next.suffix(4)

                    if next.first == "0" {
                        break
                    }

                    p = String(p.dropFirst(5))
                }

                rest = String(p.dropFirst(5))

                return Int(binaryRepresentation, radix: 2)!
            }()
            return .literalValue(literalValue)
        } else {
            let subPackets: [Packet] = {
                let p = String(data.dropFirst(6))
                debugPrint("p", p)

                let num: Int
                let toParse: String
                if p.first == "0" {
                    let rawNum = String(p.dropFirst().prefix(15))
                    toParse = String(p.dropFirst(16))
                    print("rawNum", rawNum)
                    num = Int(rawNum, radix: 2) ?? -1
                } else {
                    let rawNum = String(p.dropFirst().prefix(11))
                    toParse = String(p.dropFirst(12))
                    print("rawNum", rawNum)
                    num = Int(rawNum, radix: 2) ?? -2
                }

                var toParse2 = String(toParse)
                var packets = [Packet]()
                debugPrint("num", num)

                for _ in 0..<num {
                    debugPrint("looking for packet in", toParse2)
                    let result = parse(data: toParse2)
                    guard let packet = result.0 else {
                        break
                    }

                    packets.append(packet)
                    toParse2 = result.1
                }

                print("packets", packets)

                rest = toParse2

                return packets
            }()

            return .operator(subPackets)
        }
    }()

    return (Packet(version: version, typeId: typeId), rest)
}

enum PacketTypeId {
    case literalValue(Int)
    case `operator`([Packet])
}

struct Packet {
    let version: Int
    let typeId: PacketTypeId

    var aggregatedVersion: Int {
        switch typeId {
        case .literalValue:
            return version
        case .operator(let subPackets):
            return version + subPackets.map { $0.aggregatedVersion }.reduce(0, +)
        }
    }
}

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

// let input = "A0016C880162017C3686B18A3D4780"
// let input = "38006F45291200" // operator
// let input = "D2FE28" // literal value

let binaryInput = input
    .map { String($0) }
    .map { Int($0, radix: 16)! }
    .map { String($0, radix: 2) }
    .map { $0.leftPadding(toLength: 4, withPad: "0") }
    .joined()

let output = parse(data: binaryInput)
print(output.0!.aggregatedVersion)