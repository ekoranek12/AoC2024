import Foundation

do {
    let input = try Day4.load()
    let grid = Day4.makeGrid(from: input)
    let matches = Day4.findMatches(of: "XMAS", in: grid)
    let xMatches = Day4.findXMatches(in: grid)
} catch {
    print(error)
}
