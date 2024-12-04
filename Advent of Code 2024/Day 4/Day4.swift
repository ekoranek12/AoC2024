//
//  Day4.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/4/24.
//

import Foundation

public enum Day4 {
    public static func load() throws(FileLoader.LoadingError) -> String {
        try FileLoader.load(resource: "Day4PuzzleInput", withExtension: "txt")
    }

    public static func makeGrid(from input: String) -> [[Character]] {
        input.split(separator: "\n")
            .map { substring in
                Array(substring)
            }
    }

    public static func findMatches(of word: String, in input: [[Character]]) -> Int {
        guard let firstCharacter = word.first else { return 0 }

        // assuming the word search is square
        let validRect = CGRect(x: 0, y: 0, width: input.count, height: input.first!.count)

        var matches: Int = 0

        for y in 0..<input.count {
            let row = input[y]
            for x in 0..<row.count where row[x] == firstCharacter {
                let cursorPoint = CGPoint(x: x, y: y)

                for direction in SearchDirection.allCases {
                    let points = cursorPoint.points(to: direction, length: word.count)
                    guard points.allSatisfy({ validRect.contains($0) }) else { continue }

                    let characters = points.map { point in
                        input[Int(point.y)][Int(point.x)]
                    }

                    if String(characters) == word {
                        matches += 1
                    }
                }
            }
        }

        return matches
    }

    // This implementation is dependent on the center A in MAS
    public static func findXMatches(in input: [[Character]]) -> Int {
        // assuming the word search is square
        let validRect = CGRect(x: 0, y: 0, width: input.count, height: input.first!.count)

        var matches = 0

        for y in 0..<input.count {
            let row = input[y]
            for x in 0..<row.count where row[x] == "A" {
                let cursorPoint = CGPoint(x: x, y: y)

                let downForward = CGPoint(x: cursorPoint.x - 1, y: cursorPoint.y - 1)
                    .points(to: .downForward, length: 3)

                guard downForward.allSatisfy({ validRect.contains($0) }) else { continue }

                var characters = downForward.map { offset in
                    input[Int(offset.y)][Int(offset.x)]
                }

                let downForwardWord = String(characters)

                guard downForwardWord == "MAS" || downForwardWord == "SAM" else { continue }

                let upForward = CGPoint(x: cursorPoint.x - 1, y: cursorPoint.y + 1)
                    .points(to: .upForward, length: 3)

                guard upForward.allSatisfy({ validRect.contains($0) }) else { continue }

                characters = upForward.map { offset in
                    input[Int(offset.y)][Int(offset.x)]
                }

                let upForwardWord = String(characters)

                guard upForwardWord == "MAS" || upForwardWord == "SAM" else { continue }

                matches += 1
            }
        }

        return matches
    }
}

public enum SearchDirection: CaseIterable {
    case forward, backward
    case up, down
    case upForward, upBackward, downBackward, downForward

    var xAdjustment: Int {
        switch self {
        case .forward: 1
        case .backward: -1
        case .up: 0
        case .down: 0
        case .upForward: 1
        case .upBackward: -1
        case .downBackward: -1
        case .downForward: 1
        }
    }

    var yAdjustment: Int {
        switch self {
        case .forward: 0
        case .backward: 0
        case .up: -1
        case .down: 1
        case .upForward: -1
        case .upBackward: -1
        case .downBackward: 1
        case .downForward: 1
        }
    }
}

extension CGPoint {
    func points(to direction: SearchDirection, length: Int) -> [CGPoint] {
        var points: [CGPoint] = []

        for count in 0..<length {
            points.append(
                CGPoint(
                    x: Int(x) + (count * direction.xAdjustment),
                    y: Int(y) + (count * direction.yAdjustment))
            )
        }

        return points
    }
}
