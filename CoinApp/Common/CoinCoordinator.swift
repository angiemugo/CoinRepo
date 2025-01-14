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
    let apiKey: String

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        apiKey = try! fetchAPIKey()
    }

     func start() {
         let networkClient = CoinClient(apiKey: apiKey)
        let dataSource = RemoteDataSource(networkClient)
//         let localDataSource = LocalDataSource()
         let viewModel = CoinsListViewModel(dataSource: dataSource, coordinator: self, isFavorites: false)
        let coinVC = CoinsListViewController(viewModel: viewModel)
        coinVC.tabBarItem = UITabBarItem(title: "Coins", image: UIImage(systemName: "bitcoinsign"), selectedImage: nil)
        navigationController.pushViewController(coinVC, animated: true)
    }

     func showDetails(for coinId: String) {
         let networkClient = CoinClient(apiKey: apiKey)
        let dataSource = RemoteDataSource(networkClient)
//         let dataSource = LocalDataSource()
         let viewModel = CoinDetailViewModel(dataSource: dataSource, coinId: coinId)
        let detailsVC = CoinDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
