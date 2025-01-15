//
//  FavoritesCoordinator.swift
//  CoinApp
//
//  Created by Angie Mugo on 10/01/2025.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    var navigationController: UINavigationController
    let apiKey: String

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        apiKey = try! fetchAPIKey()
    }

    func start() {
        let networkClient = CoinClient()
        let dataSource = RemoteDataSource(networkClient)
        let viewModel = CoinsListViewModel(dataSource: dataSource,
                                           coordinator: self,
                                           isFavorites: true)
        let favoriteVC = CoinsListViewController(viewModel: viewModel)
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorites",
                                             image: UIImage(systemName: "star.fill"),
                                             selectedImage: nil)
        navigationController.pushViewController(favoriteVC, animated: true)
    }

    func showDetails(for coinId: String) {
        let networkClient = CoinClient()
        let dataSource = RemoteDataSource(networkClient)
        let viewModel = CoinDetailViewModel(dataSource: dataSource,
                                            coinId: coinId)
        let detailsVC = CoinDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
