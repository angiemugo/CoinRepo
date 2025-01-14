//
//  PerformanceChartData.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

import Foundation

struct PerformanceChartData: Hashable {
    let x: Date
    let y: Double

    init(performanceData: CoinHistoryModel) {
        self.x = performanceData.timestamp.toDate()
        self.y = performanceData.price.convertToDouble()
    }

    init(data: String, index: Int) {
        let currentDate = Date()
        let newDate = Calendar.current.date(byAdding: .hour, value: index, to: currentDate) ?? currentDate

        self.x = newDate
        self.y = data.convertToDouble()
    }
}
