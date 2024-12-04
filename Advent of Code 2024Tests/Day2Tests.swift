//
//  Day2Tests.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/2/24.
//

import Testing
@testable import Advent_of_Code_2024

struct Day2Tests {
    @Test func load() async throws {
        let input = try Day2.load()
        #expect(input.split(separator: "\n").count == 1000)
    }

    @Test func parse() async throws {
        let input = try Day2.load()
        let records = Day2.parse(input)
        #expect(records.count == 1000)
    }

    @Test func checkReport() async throws {
        let reports = [
            Day2.Report(levels: [7, 6, 4, 2, 1]),
            Day2.Report(levels: [1, 2, 7, 8, 9]),
            Day2.Report(levels: [9, 7, 6, 2, 1]),
            Day2.Report(levels: [1, 3, 2, 4, 5]),
            Day2.Report(levels: [8, 6, 4, 4, 1]),
            Day2.Report(levels: [1, 3, 6, 7, 9]),
        ]

        try Day2.check(reports[0])

        #expect(throws: Day2.ReportError.largeStep(size: 5)) {
            try Day2.check(reports[1])
        }

        #expect(throws: Day2.ReportError.largeStep(size: 4)) {
            try Day2.check(reports[2])
        }

        #expect(throws: Day2.ReportError.changeDirection) {
            try Day2.check(reports[3])
        }

        #expect(throws: Day2.ReportError.noStep) {
            try Day2.check(reports[4])
        }

        try Day2.check(reports[5])
    }

    @Test func checkDampenedReports() async throws {
        let reports = [
            Day2.Report(levels: [7, 6, 4, 2, 1]),
            Day2.Report(levels: [1, 2, 7, 8, 9]),
            Day2.Report(levels: [9, 7, 6, 2, 1]),
            Day2.Report(levels: [1, 3, 2, 4, 5]),
            Day2.Report(levels: [8, 6, 4, 4, 1]),
            Day2.Report(levels: [1, 3, 6, 7, 9]),
        ]

        try Day2.dampenedCheck(reports[0])

        #expect(throws: Day2.ReportError.self) {
            try Day2.dampenedCheck(reports[1])
        }

        #expect(throws: Day2.ReportError.self) {
            try Day2.dampenedCheck(reports[2])
        }

        try Day2.dampenedCheck(reports[3])
        try Day2.dampenedCheck(reports[4])
        try Day2.dampenedCheck(reports[5])
    }
}
