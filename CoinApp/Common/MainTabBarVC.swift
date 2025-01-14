//
//  MainTabBarVC.swift
//  CoinApp
//
//  Created by Angie Mugo on 10/01/2025.
//

import UIKit

class MainTabBarVC: UITabBarController {
    private let coinCoordinator = CoinCoordinator(navigationController: UINavigationController())
    private let favoritesCoordinator = FavoritesCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        coinCoordinator.start()
        favoritesCoordinator.start()
        viewControllers = [coinCoordinator.navigationController, favoritesCoordinator.navigationController]
    }
}
