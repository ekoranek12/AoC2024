//
//  Day3.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/3/24.
//

import Foundation
import RegexBuilder

public enum Day3 {
    public static let regex = Regex {
        "mul("
        Capture {
            OneOrMore(.digit)
        } transform: {
            Int($0)
        }
        ","
        Capture {
            OneOrMore(.digit)
        } transform: {
            Int($0)
        }
        ")"
    }

    // The location of a do/don't
    public struct Directive {
        var enabled: Bool
        var range: Range<String.Index>
    }

    // the span from a do/don't to the next do/don't
    public struct Span {
        var enabled: Bool
        var range: Range<String.Index>
    }

    public static func load() throws(FileLoader.LoadingError) -> String {
        try FileLoader.load(resource: "Day3PuzzleInput", withExtension: "txt")
    }

    public static func doRanges(_ input: String) -> [Directive] {
        input
            .matches(of: "do()")
            .map(\.range)
            .map { range in
                Directive(enabled: true, range: range)
            }
    }

    public static func dontRanges(_ input: String) -> [Directive] {
        input
            .matches(of: "don't()")
            .map(\.range)
            .map { range in
                Directive(enabled: false, range: range)
            }
    }

    public static func buildSpans(from directives: [Directive], for input: String) -> [Span] {
        var enabled: Bool = true
        var currentIndex: String.Index = input.startIndex
        let sortedDirectives = directives.sorted(using: KeyPathComparator(\.range.lowerBound))

        var spans: [Span] = []
        for directive in sortedDirectives {
            let newSpan = Span(enabled: enabled, range: currentIndex..<directive.range.lowerBound)
            spans.append(newSpan)

            enabled = directive.enabled
            currentIndex = directive.range.upperBound
        }

        return spans
    }

    public static func process(_ spans: [Span], for input: String) -> Int {
        var total = 0

        for span in spans where span.enabled {
            let substring = input[span.range]
            let matches = substring.matches(of: regex)

            let subtotal = matches.compactMap { match in
                guard let lhs = match.output.1,
                      let rhs = match.output.2
                else {
                    print("bad match")
                    return nil
                }

                return lhs * rhs
            }
            .reduce(0, +)

            total += subtotal
        }

        return total
    }
}
