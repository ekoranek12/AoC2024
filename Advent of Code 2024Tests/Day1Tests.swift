//
//  Day1Tests.swift
//  Advent of Code 2024Tests
//
//  Created by Eddie Koranek on 12/1/24.
//

import Testing
@testable import Advent_of_Code_2024

struct Day1Tests {
    let rawValues = """
        7   10
        1   6
        5   2
        9   8
        3   4
        """
    
    @Test func load() async throws {
        let value = try Day1.load()
        let split = value.split(separator: "\n")
        #expect(split.count == 1000)
    }

    @Test func parseRawString() async throws {
        let parsed = Day1.parse(rawValues)

        #expect(parsed.lhs.count == 5)
        #expect(parsed.rhs.count == 5)

        let lhs = [7, 1, 5, 9, 3]
        #expect(parsed.lhs == lhs)

        let rhs = [10, 6, 2, 8, 4]
        #expect(parsed.rhs == rhs)
    }

    @Test func parseRawStringWithParsing() async throws {
        // Second parsing approach using Swift Parsing
        let parsed = Day1.parse(rawValues)

        #expect(parsed.lhs.count == 5)
        #expect(parsed.rhs.count == 5)

        let lhs = [7, 1, 5, 9, 3]
        #expect(parsed.lhs == lhs)

        let rhs = [10, 6, 2, 8, 4]
        #expect(parsed.rhs == rhs)
    }

    @Test func sortPairs() async throws {
        let parsed = Day1.parse(rawValues)
        let sorted = Day1.sort(parsed)

        #expect(sorted.lhs.count == 5)
        #expect(sorted.rhs.count == 5)

        let lhs = [1, 3, 5, 7, 9]
        #expect(sorted.lhs == lhs)

        let rhs = [2, 4, 6, 8, 10]
        #expect(sorted.rhs == rhs)
    }

    @Test func calculateDifference() async throws {
        let parsed = Day1.parse(rawValues)
        let sorted = Day1.sort(parsed)
        let difference = Day1.calculateDifference(sorted)

        #expect(difference == 5)
    }

    @Test func countElements() async throws {
        let rawValues = """
            7   5
            1   6
            5   1
            9   1
            3   4
            
            """

        let parsed = Day1.parse(rawValues)
        let sorted = Day1.sort(parsed)
        let counted = Day1.countElements(sorted.rhs)

        #expect(counted.keys.count == 4)
        #expect(counted[1] == 2)
        #expect(counted[4] == 1)
        #expect(counted[5] == 1)
        #expect(counted[6] == 1)
    }

    @Test func similarity() async throws {
        let rawValues = """
            7   5
            1   6
            5   1
            9   1
            3   4
            
            """

        let parsed = Day1.parse(rawValues)
        let sorted = Day1.sort(parsed)
        let similarity = Day1.calculateSimilarity(sorted)

        #expect(similarity == 7)
    }

    // Expected Results
    @Test func expectedDifference() async throws {
        let value = try Day1.load()
        let parsed = Day1.parse(value)
        let sorted = Day1.sort(parsed)
        let difference = Day1.calculateDifference(sorted)

        #expect(difference == 1_603_498)
    }

    @Test func expectedSimilarity() async throws {
        let value = try Day1.load()
        let parsed = Day1.parse(value)
        let sorted = Day1.sort(parsed)
        let similarity = Day1.calculateSimilarity(sorted)

        #expect(similarity == 25_574_739)
    }
}
