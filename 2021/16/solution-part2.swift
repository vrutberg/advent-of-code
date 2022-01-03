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

enum Length {
    case bits
    case numberOfSubPackets
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

    let rawTypeId: Int = {
        let p = String(data.prefix(6).suffix(3))
        let value = Int(p, radix: 2)
        return value!
    }()

    let typeId: PacketTypeId = {
        if rawTypeId == 4 {
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
                let length: Length
                if p.first == "0" {
                    // 100111000000000001011010110000101111100011110000
                    // VVVTTTILLLLLLLLLLLLLLL
                    let rawNum = String(p.dropFirst().prefix(15))
                    toParse = String(p.dropFirst(16))
                    print("rawNum", rawNum)
                    num = Int(rawNum, radix: 2)!
                    length = .bits
                } else {
                    let rawNum = String(p.dropFirst().prefix(11))
                    toParse = String(p.dropFirst(12))
                    // print("rawNum", rawNum)
                    num = Int(rawNum, radix: 2)!
                    length = .numberOfSubPackets
                }

                var toParse2 = String(toParse)
                var packets = [Packet]()
                debugPrint("num", num)

                if length == .numberOfSubPackets {
                    print("expecting to find \(num) packets")
                    for _ in 0..<num {
                        // debugPrint("looking for packet in", toParse2)
                        let result = parse(data: toParse2)
                        guard let packet = result.0 else {
                            break
                        }

                        packets.append(packet)
                        toParse2 = result.1
                    }
                } else {
                    print("expecting to parse \(num) bits")
                    var numberOfParsedBytes = 0
                    while numberOfParsedBytes < num {
                        let result = parse(data: toParse2)
                        guard let packet = result.0 else {
                            break
                        }

                        packets.append(packet)
                        numberOfParsedBytes += toParse2.count - result.1.count
                        toParse2 = result.1
                    }
                }
                
                // print("packets", packets)
                if rawTypeId == 7 {
                    print("found \(packets.count) packets")
                }

                rest = toParse2

                return packets
            }()

            return .operator(subPackets)
        }
    }()

    return (Packet(version: version, rawTypeId: rawTypeId, typeId: typeId), rest)
}

enum PacketTypeId {
    case literalValue(Int)
    case `operator`([Packet])
}

struct Packet: CustomStringConvertible {
    let version: Int
    let rawTypeId: Int
    let typeId: PacketTypeId

    var description: String {
        switch typeId {
        case .literalValue(let value):
            return "LiteralValue(\(value))"
        case .operator(let subPackets):
            return "\(operatorSign)(\(subPackets.map(\.description).joined(separator: ", ")))"
        }
    }

    var aggregatedVersion: Int {
        switch typeId {
        case .literalValue:
            return version
        case .operator(let subPackets):
            return version + subPackets.map { $0.aggregatedVersion }.reduce(0, +)
        }
    }

    var operatorSign: String {
        guard case .`operator` = typeId else {
            return ""
        }

        switch rawTypeId {
            case 0: // sum
                return "+"
            case 1: // product
                return "*"
            case 2: // minimum
                return "min"
            case 3: // maximum
                return "max"
            case 5: // greater-than
                return ">"
            case 6: // less-than
                return "<"
            case 7: // equal
                return "=="

            default:
                fatalError()
        }
    }

    var aggregatedValue: Int {
        switch typeId {
        case .literalValue(let value):
            return value
            
        case .operator(let subPackets):
            switch rawTypeId {
            case 0: // sum
                return subPackets.map(\.aggregatedValue).reduce(0, +)
            case 1: // product
                return subPackets.map(\.aggregatedValue).reduce(1, *)
            case 2: // minimum
                return subPackets.map(\.aggregatedValue).sorted().first!
            case 3: // maximum
                return subPackets.map(\.aggregatedValue).sorted().last!
            case 5: // greater-than
                let values = subPackets.map(\.aggregatedValue)
                assert(values.count == 2, "must have two packets in greater-than packet, found \(values.count)")
                let first = values.first!
                let second = values.last!

                return first > second ? 1 : 0
            case 6: // less-than
                let values = subPackets.map(\.aggregatedValue)
                assert(values.count == 2, "must have two packets in less-than packet, found \(values.count)")
                let first = values.first!
                let second = values.last!

                return first < second ? 1 : 0
            case 7: // equal
                let values = subPackets.map(\.aggregatedValue)
                assert(values.count == 2, "must have two packets in equality packet, found \(values.count)")
                let first = values.first!
                let second = values.last!

                return first == second ? 1 : 0

            default:
                fatalError()
            }
        }
    }
}

guard let input = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError()
}

// let input = "9C005AC2F8F0"
// let input = "9C0141080250320F1802104A08"
// let input = "38006F45291200" // operator
// let input = "D2FE28" // literal value

let binaryInput = input
    .map { String($0) }
    .map { Int($0, radix: 16)! }
    .map { String($0, radix: 2) }
    .map { $0.leftPadding(toLength: 4, withPad: "0") }
    .joined()

print(binaryInput)

let output = parse(data: binaryInput)
print(output.0!.aggregatedValue)