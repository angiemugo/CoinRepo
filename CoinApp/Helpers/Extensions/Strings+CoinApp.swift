//
//  Strings+CoinApp.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

import Foundation


extension String {
    /// Converts a numeric string into a formatted currency string with `B` for billions, `M` for millions, and an optional currency symbol.
    /// Always displays two decimal points for consistency.
    /// - Parameters:
    ///   - currencySymbol: An optional currency symbol to prepend to the formatted string.
    /// - Returns: A formatted string, or the original string if conversion fails.
    func formattedCurrency(currencySymbol: String? = "$") -> String {
        guard let doubleValue = Double(self) else { return self }
        return doubleValue.formattedCurrencyWithSuffix(currencySymbol: currencySymbol)
    }

    /// Converts a timestamp string to a Date object.
     /// - Parameter defaultValue: The value to return if the string cannot be converted to a valid timestamp.
     /// - Returns: A `Date` object, or the `defaultValue` if conversion fails.
     func toDate(defaultValue: Date? = nil) -> Date? {
         guard let timeInterval = TimeInterval(self) else { return defaultValue }
         return timeInterval.toDate()
     }

    /// Converts a string to a double.
    ///
    /// - Parameters: A fallback value to use if the conversion fails. Default is `0.0`.
    /// - Returns: A `Double` value if the conversion succeeds, otherwise the fallback value.
    func convertToDouble(fallback: Double = 0.0) -> Double {
        return Double(self) ?? fallback
    }
}
