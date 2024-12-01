import Foundation

do {
    let value = try Day1.load()
    let pairs = Day1.parse(value)
    let sortedPairs = Day1.sort(pairs)
    let difference = Day1.calculateDifference(sortedPairs)

    let similarity = measureDuration("Similarity") {
        Day1.calculateSimilarity(sortedPairs)
    }
} catch {
    print(error)
}
