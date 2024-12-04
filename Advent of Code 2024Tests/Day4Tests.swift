//
//  Day4Tests.swift
//  Advent of Code 2024Tests
//
//  Created by Eddie Koranek on 12/4/24.
//

import Foundation
import Testing
@testable import Advent_of_Code_2024

struct Day4Tests {
    let input = """
        MMMSXXMASM
        MSAMXMSMSA
        AMXSXMAAMM
        MSAMASMSMX
        XMASAMXAMM
        XXAMMXXAMA
        SMSMSASXSS
        SAXAMASAAA
        MAMMMXMMMM
        MXMXAXMASX
        """

    @Test func load() async throws {
        let input = try Day4.load()
        #expect(input.split(separator: "\n").count == 140)
    }

    @Test func makeGrid() async throws {
        let output = Day4.makeGrid(from: input)

        let expectation: [[Character]] = [
            ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
            ["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],
            ["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],
            ["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],
            ["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],
            ["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],
            ["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],
            ["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],
            ["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],
            ["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"],
        ]

        #expect(output == expectation)
    }

    @Test func findMatches() async throws {
        let grid = Day4.makeGrid(from: input)
        let matches = Day4.findMatches(of: "XMAS", in: grid)

        #expect(matches == 18)
    }

    @Test func findXMatches() async throws {
        let grid = Day4.makeGrid(from: input)
        let matches = Day4.findXMatches(in: grid)

        #expect(matches == 9)
    }
}
