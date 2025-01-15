//
//  Date+CoinApp.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

import Foundation

extension Date {
    func getDay() -> String {
         let dayFormatter = DateFormatter()
         dayFormatter.dateFormat = "EEEE"
         return dayFormatter.string(from: self)
     }
}
