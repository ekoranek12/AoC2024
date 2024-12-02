//
//  Day1.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/1/24.
//

import Foundation
import Parsing

public struct Pair {
    var lhs: [Int]
    var rhs: [Int]

    init(
        lhs: [Int] = [],
        rhs: [Int] = []
    ) {
        self.lhs = lhs
        self.rhs = rhs
    }
}

public enum Day1 {
    public static func load() throws(FileLoader.LoadingError) -> String {
        try FileLoader.load(resource: "Day1PuzzleInput", withExtension: "txt")
    }

    public static func parse(_ input: String) -> Pair {
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
            .reduce(into: Pair()) { partialResult, pair in
                partialResult.lhs.append(pair.0)
                partialResult.rhs.append(pair.1)
            }
    }

    // Resolving using Swift Parsing
    public static func parse2(_ input: String) -> Pair {
        let parser = Parse(input: Substring.self) {
            Many {
                Digits()
                "   "
                Digits()
            } separator: {
                "\n"
            }
        }

        do {
            return try parser.parse(input.trimmingCharacters(in: .whitespacesAndNewlines))
                .reduce(into: Pair()) { partialResult, pair in
                    partialResult.lhs.append(pair.0)
                    partialResult.rhs.append(pair.1)
                }
        } catch {
            print(error)
            fatalError()
        }
    }

    public static func sort(_ input: Pair) -> Pair {
        Pair(
            lhs: input.lhs.sorted(),
            rhs: input.rhs.sorted()
        )
    }

    public static func calculateDifference(_ input: Pair) -> Int {
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

    public static func calculateSimilarity(_ input: Pair) -> Int {
        var score = 0

        let counts = countElements(input.rhs)

        for value in input.lhs {
            let count = counts[value, default: 0]
            score += (value * count)
        }

        return score
    }
}
