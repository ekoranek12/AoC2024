import Foundation

do {
    let input = try Day3.load()
    let matches = input.matches(of: Day3.regex)

    let total = matches.compactMap { match in
        guard let lhs = Int(match.output.1),
              let rhs = Int(match.output.2)
        else {
            print("bad match")
            return nil
        }

        return lhs * rhs
    }
        .reduce(0, +)

    let dos = Day3.doRanges(input)
    let donts = Day3.dontRanges(input)

    let spans = Day3.buildSpans(from: dos + donts, for: input)
    let filteredTotal = Day3.process(spans, for: input)

} catch {
    print(error)
}
