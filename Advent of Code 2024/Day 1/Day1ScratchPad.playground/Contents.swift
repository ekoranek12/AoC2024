import Foundation

typealias ListPair = (lhs: [Int], rhs: [Int])

let input = Bundle.main.url(forResource: "Day1PuzzleInput", withExtension: "txt")
let data = try? Data(contentsOf: input!)
let string = String(data: data!, encoding: .utf8)

enum LoadingError: Error {
    case missingFile
    case malformedData(_ error: Error)
    case invalidContents
}

func loadInputs() throws(LoadingError) -> String {
    guard let input = Bundle.main.url(forResource: "Day1PuzzleInput", withExtension: "txt") else {
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

func parse(_ input: String) -> ListPair {
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
        .reduce(([Int](), [Int]())) { partialResult, pair in
            (
                partialResult.0 + [pair.0],
                partialResult.1 + [pair.1]
            )
        }
}

func sort(_ input: ListPair) -> ListPair {
    (
        input.lhs.sorted(),
        input.rhs.sorted()
    )
}

func calculateDifference(_ input: ListPair) -> Int {
    zip(input.lhs, input.rhs)
        .reduce(0) { partialResult, pair in
            return partialResult + abs(pair.1 - pair.0)
        }
}

func calculateSimilarity(_ input: ListPair) -> Int {
    var score = 0

    for value in input.lhs {
        let count = input.rhs.count { compareValue in
            value == compareValue
        }

        score += (value * count)
    }

    return score
}

let value = try! loadInputs()
let pairs = parse(value)
let sortedPairs = sort(pairs)
//let difference = calculateDifference(sortedPairs)
let similarity = calculateSimilarity(sortedPairs)