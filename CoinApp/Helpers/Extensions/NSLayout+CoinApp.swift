//
//  NSLayout+CoinApp.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

import UIKit

extension NSLayoutConstraint {
    @discardableResult func activate() -> NSLayoutConstraint {
        isActive = true
        return self
    }
}
