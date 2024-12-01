//
//  FileLoader.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/1/24.
//

import Foundation

public struct FileLoader {
    public enum LoadingError: Error {
        case missingFile
        case malformedData(_ error: Error)
        case invalidContents
    }

    public static func load(resource: String, withExtension ext: String) throws(LoadingError) -> String {
        guard let input = Bundle.main.url(forResource: resource, withExtension: ext) else {
            throw .missingFile
        }

        let data: Data
        do {
            data = try Data(contentsOf: input)
        } catch {
            throw .malformedData(error)
        }

        guard let string = String(data: data, encoding: .utf8) else {
            throw .invalidContents
        }

        return string
    }
}
