//
//  Double+CoinApp.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

import Foundation

extension Double {
    /// Formats the number using `B` for billions, `M` for millions, and includes an optional currency symbol.
    /// Always displays two decimal points for consistency.
    /// - Parameters:
    ///   - currencySymbol: An optional currency symbol to prepend to the formatted string.
    /// - Returns: A string representing the formatted value with currency and suffix.
    func formattedCurrencyWithSuffix(currencySymbol: String? = nil) -> String {
        let billion = 1_000_000_000.0
        let million = 1_000_000.0

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = currencySymbol ?? ""
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        if self >= billion {
            let value = self / billion
            return "\(formatter.string(from: NSNumber(value: value)) ?? "\(value)")B"
        } else if self >= million {
            let value = self / million
            return "\(formatter.string(from: NSNumber(value: value)) ?? "\(value)")M"
        } else {
            return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
        }
    }
}
