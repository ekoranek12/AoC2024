//
//  Day4Tests+CGPoint.swift
//  Advent of Code 2024Tests
//
//  Created by Eddie Koranek on 12/4/24.
//

import Testing
import Foundation
@testable import Advent_of_Code_2024

struct Day4Tests_CGPoint {
    // Horizontal
    @Test func forwardDirection() async throws {
        let points = CGPoint(x: 1, y: 1).points(to: .forward, length: 4)
        let expectation = [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 2, y: 1),
            CGPoint(x: 3, y: 1),
            CGPoint(x: 4, y: 1),
        ]

        #expect(points == expectation)
    }

    @Test func backwardsDirection() async throws {
        let points = CGPoint(x: 1, y: 1).points(to: .backward, length: 4)
        let expectation = [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 0, y: 1),
            CGPoint(x: -1, y: 1),
            CGPoint(x: -2, y: 1),
        ]

        #expect(points == expectation)
    }

    // Vertical
    @Test func upDirection() async throws {
        let points = CGPoint(x: 1, y: 1).points(to: .up, length: 4)
        let expectation = [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 1, y: 0),
            CGPoint(x: 1, y: -1),
            CGPoint(x: 1, y: -2),
        ]

        #expect(points == expectation)
    }

    @Test func downDirection() async throws {
        let points = CGPoint(x: 1, y: 1).points(to: .down, length: 4)
        let expectation = [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 1, y: 2),
            CGPoint(x: 1, y: 3),
            CGPoint(x: 1, y: 4),
        ]

        #expect(points == expectation)
    }

    // Diagonal
    @Test func forwardUpDirection() async throws {
        let points = CGPoint(x: 1, y: 1).points(to: .upForward, length: 4)
        let expectation = [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 2, y: 0),
            CGPoint(x: 3, y: -1),
            CGPoint(x: 4, y: -2),
        ]

        #expect(points == expectation)
    }

    @Test func backwardUpDirection() async throws {
        let points = CGPoint(x: 1, y: 1).points(to: .upBackward, length: 4)
        let expectation = [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 0, y: 0),
            CGPoint(x: -1, y: -1),
            CGPoint(x: -2, y: -2),
        ]

        #expect(points == expectation)
    }

    // Vertical
    @Test func forwardDownDirection() async throws {
        let points = CGPoint(x: 1, y: 1).points(to: .downForward, length: 4)
        let expectation = [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 2, y: 2),
            CGPoint(x: 3, y: 3),
            CGPoint(x: 4, y: 4),
        ]

        #expect(points == expectation)
    }

    @Test func backwardDownDirection() async throws {
        let points = CGPoint(x: 1, y: 1).points(to: .downBackward, length: 4)
        let expectation = [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 0, y: 2),
            CGPoint(x: -1, y: 3),
            CGPoint(x: -2, y: 4),
        ]

        #expect(points == expectation)
    }
}
