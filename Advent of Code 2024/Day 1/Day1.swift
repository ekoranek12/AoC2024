//
//  Day1.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/1/24.
//

public typealias ListPair = (lhs: [Int], rhs: [Int])

public enum Day1 {
    public static func load() throws(FileLoader.LoadingError) -> String {
        try FileLoader.load(resource: "Day1PuzzleInput", withExtension: "txt")
    }

    public static func parse(_ input: String) -> ListPair {
        input
            .split(separator: "\n")
            .map { row in
                let split = row.split(separator: " ", omittingEmptySubsequences: true)
                return (split.first, split.last)
            }
            .compactMap { (lhs: (any StringProtocol)?, rhs: (any StringProtocol)?) -> (Int, Int)? in
                guard let lhs, let rhs,
                      let first = Int(lhs),
                      let last = Int(rhs)
                else {
                    return nil
                }

                return (first, last)
            }
            .reduce(([Int](), [Int]())) { partialResult, pair in
                (
                    partialResult.0 + [pair.0],
                    partialResult.1 + [pair.1]
                )
            }
    }

    public static func sort(_ input: ListPair) -> ListPair {
        (
            input.lhs.sorted(),
            input.rhs.sorted()
        )
    }

    public static func calculateDifference(_ input: ListPair) -> Int {
        zip(input.lhs, input.rhs)
            .reduce(0) { partialResult, pair in
                return partialResult + abs(pair.1 - pair.0)
            }
    }

    public static func countElements(_ input: [Int]) -> [Int: Int] {
        Dictionary(
            input.map { ($0, 1) },
            uniquingKeysWith: +
        )
    }

    public static func calculateSimilarity(_ input: ListPair) -> Int {
        var score = 0

        let counts = countElements(input.rhs)

        for value in input.lhs {
            let count = counts[value, default: 0]
            score += (value * count)
        }

        return score
    }
}
