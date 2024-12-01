//
//  FunctionDuration.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/1/24.
//

import Foundation

public func measureDuration<Output>(_ title: String, function: () -> Output) -> Output {
    let start = Date.now.timeIntervalSince1970

    let output = function()
    let end = Date.now.timeIntervalSince1970

    print("Function \(title) took: \(end - start) seconds")
    return output
}
