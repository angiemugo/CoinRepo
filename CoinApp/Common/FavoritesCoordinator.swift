//
//  FavoritesCoordinator.swift
//  CoinApp
//
//  Created by Angie Mugo on 10/01/2025.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let dataSource = LocalDataSource()
        let viewModel = CoinsListViewModel(dataSource: dataSource, coordinator: self, isFavorites: true)
        let favoriteVC = CoinsListViewController(viewModel: viewModel)
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star.fill"), selectedImage: nil)
        
        navigationController.pushViewController(favoriteVC, animated: true)
    }
    
    func showDetails(for coinId: String) {
        let viewModel = CoinDetailViewModel(dataSource: LocalDataSource(), coinId: coinId)
        let detailsVC = CoinDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
