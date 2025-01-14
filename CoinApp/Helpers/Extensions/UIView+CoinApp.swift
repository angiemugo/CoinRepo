//
//  UIView+CoinApp.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

import UIKit

extension UIView {
    /// Pins the edges of the view to its superview's edges with optional insets.
    /// - Parameter insets: The insets to apply to the edges (default is `.zero`).
    func fillToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            print("Error: The view has no superview.")
            return
        }

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        ])
    }
}
