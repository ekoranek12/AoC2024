import Foundation

do {
    let input = try Day2.load()
    let reports = Day2.parse(input)
    // Part 1
    let safeReports = reports.compactMap { report in
        try? Day2.check(report)
    }

    // Part 2
    let dampenedReports = reports.compactMap { report in
        try? Day2.dampenedCheck(report)
    }
} catch {
    print(error)
}
