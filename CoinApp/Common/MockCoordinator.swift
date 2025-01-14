//
//  MockCoordinator.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

import UIKit

class MockCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {}
    func showDetails(for coinId: String) {}
}
