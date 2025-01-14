//
//  TimePeriod.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

enum TimePeriod: String, CaseIterable, Identifiable {
    var id: Self {
        return self
    }

    case oneHour = "1h"
    case threeHours = "3h"
    case twelveHours = "12h"
    case twentyFourHours = "24h"
    case sevenDays = "7d"
    case thirtyDays = "30d"
    case threeMonths = "3m"
    case oneYear = "1y"
    case threeYears = "3y"
    case fiveYears = "5y"

    static var defaultValue: TimePeriod {
        return .twentyFourHours
    }
}
