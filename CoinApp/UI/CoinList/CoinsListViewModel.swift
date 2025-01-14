//
//  CoinsListViewModel.swift
//  CoinApp
//
//  Created by Angie Mugo on 09/01/2025.
//

import Foundation
import UIKit
import Combine

class CoinsListViewModel: CoinListViewModelType {
    private let dataSource: DataSource
    private let coordinator: Coordinator
    private var allCoins = [UICoinModel]()
    private var cancellables: [AnyCancellable] = []
    var currentPage = 0
    var isFavorites: Bool

    init(dataSource: DataSource, coordinator: Coordinator, isFavorites: Bool) {
        self.dataSource = dataSource
        self.coordinator = coordinator
        self.isFavorites = isFavorites
    }

    func transform(input: CoinListVMInput) -> CoinListViewModelOutput {
        let pageSize = 20
        let loadCoins = input.loadMore
                    .flatMap { [unowned self] page -> AnyPublisher<CoinListLoadingState, Never> in
                        Future { promise in
                            Task { @MainActor in
                                do {
                                    self.currentPage = page
                                    let coinList = try await self.dataSource.getCoins(offset: page * pageSize)
                                    let favoriteIDs = FavoritesManager.shared.getFavoriteIDs()
                                    let models = coinList.map { UICoinModel(coinModel: $0, isFavorite: favoriteIDs.contains($0.id)) }

                                    let uniqueModels = models.filter { model in
                                        !self.allCoins.contains(where: { $0.id == model.id })
                                    }

                                    self.allCoins.append(contentsOf: uniqueModels)

                                    let filteredModels = self.isFavorites ? self.allCoins.filter { $0.isFavorite } : self.allCoins
                                    promise(.success(.loaded(filteredModels)))
                                } catch {
                                    promise(.success(.error(error as! CoinAppClientError)))
                                }
                            }
                        }.eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()


        let sortedCoins = Publishers.CombineLatest(loadCoins, input.sortOption)
            .map { state, sortOption -> CoinListLoadingState in
                guard case let .loaded(coins) = state else { return state }
                let sorted = self.sort(coins: coins, by: sortOption)
                return .loaded(sorted)
            }
            .eraseToAnyPublisher()


        input.selection
            .sink { [unowned self] coinId in
                self.gotoCoinDetail(for: coinId)
            }
            .store(in: &cancellables)

        input.favoriteCoin
            .sink { [unowned self] coin in
                if coin.isFavorite {
                    self.removeFavorite(for: coin)
                } else {
                    self.saveFavorite(for: coin)
                }
            }
            .store(in: &cancellables)

        let initialState: CoinListViewModelOutput = .just(.loading)

        return Publishers.Merge3(sortedCoins, initialState, loadCoins)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }


    private func sort(coins: [UICoinModel], by sortOption: SortOptions) -> [UICoinModel] {
          switch sortOption {
          case .price:
              return coins.sorted { $0.price.convertToDouble() > $1.price.convertToDouble() }
          case .performance:
              return coins.sorted { $0.currentPerformance > $1.currentPerformance }
          }
      }

    func gotoCoinDetail(for coin: String) {
        coordinator.showDetails(for: coin)
    }

    func saveFavorite(for coin: UICoinModel) {
        coin.isFavorite = true
        FavoritesManager.shared.addFavorite(coin.id)
    }

    func removeFavorite(for coin: UICoinModel) {
        coin.isFavorite = false
        FavoritesManager.shared.removeFavorite(coin.id)
    }
}
