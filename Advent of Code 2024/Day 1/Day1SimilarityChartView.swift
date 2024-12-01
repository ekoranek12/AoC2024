//
//  Day1SimilarityChartView.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/1/24.
//

import Charts
import Observation
import SwiftUI

struct Day1SimilarityChartView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        List {
            if let values = viewModel.chartValues {
                Chart {
                    ForEach(zip: values) { (pair: (lhs: Int, rhs: Int), index: Int) in
                        AreaMark(x: .value("Index", index),
                                 yStart: .value("lhs", pair.lhs),
                                 yEnd: .value("rhs", pair.rhs))
                    }
                }
                .chartYScale(domain: [0, 100_000])
                .chartXScale(domain: [0, 1_000])
                .aspectRatio(1, contentMode: .fit)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.loadValues()
        }
    }
}

extension Day1SimilarityChartView {
    @Observable class ViewModel {
        var zippedValues: [(Int, Int)] = []
        var chartValues: [(Int, Int)]?

        func loadValues() {
            let input = try! Day1.load()
            let parsed = Day1.parse(input)
            let sorted = Day1.sort(parsed)

            chartValues = zip(sorted.lhs, sorted.rhs)
                .map { lhs, rhs in
                    (lhs, rhs)
                }
        }
    }
}

#Preview {
    Day1SimilarityChartView()
}
