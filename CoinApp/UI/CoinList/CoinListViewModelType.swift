//
//  CoinListViewModelType.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

import Combine

typealias CoinListViewModelOutput = AnyPublisher<CoinListLoadingState, Never>

enum SortOptions {
    case price
    case performance
}

struct CoinListVMInput {
    let loadMore: AnyPublisher<Int, Never>
    let sortOption: AnyPublisher<SortOptions, Never>
    let isFavorite: AnyPublisher<Bool, Never>
    let selection: AnyPublisher<String, Never>
    let favoriteCoin: AnyPublisher<UICoinModel, Never>
}

enum CoinListLoadingState: Equatable {
    static func == (lhs: CoinListLoadingState, rhs: CoinListLoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading):
            return true
        case let (.loaded(lhsCoins), .loaded(rhsCoins)):
            return lhsCoins == rhsCoins
        case let (.error(lhsError), .error(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }

    case idle
    case loading
    case loaded([UICoinModel])
    case error(CoinAppClientError)
}

protocol CoinListViewModelType {
    func transform(input: CoinListVMInput) -> CoinListViewModelOutput
}
