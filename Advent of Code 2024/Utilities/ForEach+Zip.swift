//
//  ForEach+Zip.swift
//  Advent of Code 2024
//
//  Created by Eddie Koranek on 12/1/24.
//

import Charts
import SwiftUI

extension ForEach {
    init<InnerData>(
        zip inner: InnerData,
        @ChartContentBuilder content: @escaping (Data.Element) -> Content
    ) where
        InnerData: RandomAccessCollection,
        ID == Int,
        Data == Array<(InnerData.Element, ClosedRange<Int>.Element)>,
        Content: ChartContent
    {
        self = ForEach(Array(zip(inner, .zero...inner.count)), id: \.1) { pair in
            content(pair)
        }
    }
}

