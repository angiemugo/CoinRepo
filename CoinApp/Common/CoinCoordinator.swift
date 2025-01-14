//
//  CoinCoordinator.swift
//  CoinApp
//
//  Created by Angie Mugo on 10/01/2025.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
    func showDetails(for coin: String)
}


class CoinCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let networkClient = CoinClient()
        let dataSource = RemoteDataSource(networkClient)
        let viewModel = CoinsListViewModel(dataSource: dataSource,
                                           coordinator: self,
                                           isFavorites: false)
        let coinVC = CoinsListViewController(viewModel: viewModel)
        coinVC.tabBarItem = UITabBarItem(title: "Coins",
                                         image: UIImage(systemName: "bitcoinsign"),
                                         selectedImage: nil)
        navigationController.pushViewController(coinVC, animated: true)
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
