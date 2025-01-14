//
//  TimeInterval+CoinApp.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

import Foundation

extension TimeInterval {
    /// Converts a timestamp (TimeInterval) to a Date object.
    /// - Returns: A `Date` object representing the timestamp.
    func toDate() -> Date {
        return Date(timeIntervalSince1970: self)
    }
}
