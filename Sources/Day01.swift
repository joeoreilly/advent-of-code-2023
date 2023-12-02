import Foundation

struct Day01: AdventDay {
    var data: String
    var entities: [String] {
        data.split(separator: "\n").compactMap { String($0) }
    }
    
    func part1() -> Any {
        func takeFirstAndLastInts(from string: String) -> Int? {
            let ints = string
                .map(String.init)
                .compactMap(Int.init)
            
            guard let first = ints.first, let last = ints.last else {
                return nil
            }
            
            return (first * 10) + last
        }
        
        return entities
            .compactMap(takeFirstAndLastInts(from:))
            .reduce(0, +)
    }
    
    func part2() -> Any {
        return entities
            .map(readValues(from:))
            .compactMap { values -> Int? in
                guard let first = values.first,
                      let last = values.last
                else { return nil}
                
                return (first * 10) + last
            }
            .reduce(0, +)
    }
    
    private func readValues(from line: String) -> [Int] {
        func nextValue(in string: String) -> Int? {
            if let first = string.first, let int = Int(String(first)) {
                return int
            }
            return Digit.matchAtFront(of: string)?.intValue
        }
        
        return line
            .consume(with: nextValue(in:))
            .compactMap({ $0 })
    }
}

enum Digit: String, CaseIterable {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    
    var intValue: Int {
        Digit.allCases.firstIndex(of: self)! + 1
    }
    
    static func matchAtFront(of string: String) -> Digit? {
        for d in Self.allCases {
            guard let endIndex = string.index(string.startIndex,
                                              offsetBy: d.rawValue.count,
                                              limitedBy: string.endIndex)
            else { continue }
            
            let sub = string[string.startIndex..<endIndex]
            if let digit = Digit(rawValue: String(sub)) {
                return digit
            }
        }
        
        return nil
    }
}
