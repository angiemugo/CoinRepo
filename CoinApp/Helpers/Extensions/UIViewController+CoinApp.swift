//
//  UIViewController+CoinApp.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

import UIKit
import SwiftUI

extension UIViewController {
    func AddSwiftUIView<Content: View>(_ view: Content) -> UIViewController {
        let hostingController = UIHostingController(rootView: view)
        addChild(hostingController)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        hostingController.view.fillToSuperview()
        return hostingController
    }
}
