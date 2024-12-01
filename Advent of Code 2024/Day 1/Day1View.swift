//
//  Day1View.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/1/24.
//

import SwiftUI

struct Day1View: View {
    var body: some View {
        List {
            NavigationLink {
                Day1SimilarityChartView()
            } label: {
                Label("Similarity Chart", systemImage: "chart.line.uptrend.xyaxis")
            }
        }
        .navigationTitle("Day 1")
    }
}

#Preview {
    NavigationView {
        Day1View()
    }
}
