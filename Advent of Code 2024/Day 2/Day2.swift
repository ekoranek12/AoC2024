//
//  Day2.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/2/24.
//

import Foundation

public enum Day2 {
    public struct Report {
        public var levels: [Int]
    }
    
    public static func load() throws(FileLoader.LoadingError) -> String {
        try FileLoader.load(resource: "Day2PuzzleInput", withExtension: "txt")
    }
    
    public static func parse(_ input: String) -> [Report] {
        input
            .split(separator: "\n")
            .map { row in
                let levels = row.split(separator: " ")
                    .map(String.init)
                    .compactMap(Int.init)
                
                return Report(levels: levels)
            }
    }
    
    public struct Step {
        var direction: Direction
        var amount: Int
        
        init(previous: Int, current: Int) {
            self.direction = previous.direction(to: current)
            self.amount = abs(previous - current)
        }
    }
    
    public enum Direction {
        case increasing, decreasing, flat
    }
    
    public enum ReportError: Error, Equatable {
        case changeDirection
        case noStep
        case largeStep(size: Int)
    }

    @discardableResult
    public static func check(_ report: Report) throws(ReportError) -> Report {
        var currentLevel: Int?
        var direction: Direction?
        
        for level in report.levels {
            if let currentLevel {
                let step = Step(previous: currentLevel, current: level)
                
                if direction == nil {
                    direction = step.direction
                }
                
                guard step.amount <= 3 else {
                    throw .largeStep(size: step.amount)
                }
                
                guard step.amount > 0 else {
                    throw .noStep
                }
                
                guard step.direction == direction else {
                    throw .changeDirection
                }
            }
            
            currentLevel = level
        }

        return report
    }

    @discardableResult
    public static func dampenedCheck(_ report: Report) throws(ReportError) -> Report {
        return try bruteForce(report)
        
        var hasSkipped: Bool = false
        var currentLevel: Int?
        var direction: Direction?

        var safeLevels: [Int] = []

        for level in report.levels {
            if let currentLevel {
                let step = Step(previous: currentLevel, current: level)
                
                if direction == nil {
                    direction = step.direction
                }
                
                guard step.amount <= 3 else {
                    if hasSkipped {
                        return try bruteForce(report)
                    } else {
                        hasSkipped = true
                        continue
                    }
                }
                
                guard step.amount > 0 else {
                    if hasSkipped {
                        return try bruteForce(report)
                    } else {
                        hasSkipped = true
                        continue
                    }
                }
                
                guard step.direction == direction else {
                    if hasSkipped {
                        return try bruteForce(report)
                    } else {
                        hasSkipped = true
                        continue
                    }
                }
            }

            safeLevels.append(level)
            currentLevel = level
        }

        return try check(report)
    }

    static func bruteForce(_ report: Report) throws(ReportError) -> Report {
        for count in 0..<report.levels.count {
            var levelCopy = report.levels
            levelCopy.remove(at: count)

            do {
                return try check(Report(levels: levelCopy))
            } catch {
                continue
            }
        }

        throw .noStep
    }

    
    //    public static func parse(_ input: String) -> [Report] {
    //        let parser = Parse(input: Substring.self) {
    //            Many {
    //                Many(1...) {
    //                    Digits()
    //                } separator: {
    //                    " "
    //                }
    //            } separator: {
    //                "\n"
    //            }
    //        }
    //
    //        return try! parser.parse(input.trimmingCharacters(in: .whitespacesAndNewlines))
    //            .map { input in
    //                Report(levels: input)
    //            }
    //    }
}

extension Int {
    func direction(to: Int) -> Day2.Direction {
        if self > to {
            .decreasing
        } else if self < to {
            .increasing
        } else {
            .flat
        }
    }
}
