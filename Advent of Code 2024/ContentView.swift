//
//  ContentView.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    NavigationStack {
                        Day1View()
                    }
                } label: {
                    Label("Day 1", systemImage: "1.circle.fill")
                }

            }
            .navigationTitle("AoC '24")
        } detail: {
            EmptyView()
        }
    }
}

#Preview {
    ContentView()
}
