//
//  CoinListViewModelTests.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

import XCTest
import Combine
@testable import CoinApp

final class CoinsListViewModelTests: XCTestCase {
    var viewModel: CoinsListViewModel!
    var localDataSource: LocalDataSource!
    var cancellables: Set<AnyCancellable>!
    var mockCoordinator: MockCoordinator!
    var mockDataSource: MockLocalDataSource!

    var input: CoinListVMInput!
    let loadMoreSubject = PassthroughSubject<Int, Never>()

    override func setUp() {
        super.setUp()
        localDataSource = LocalDataSource()
        mockDataSource = MockLocalDataSource()
        mockCoordinator = MockCoordinator(navigationController: UINavigationController())
        viewModel = CoinsListViewModel(dataSource: mockDataSource,
                                       coordinator: mockCoordinator,
                                       isFavorites: false)
        cancellables = []
        let sortOptionSubject = PassthroughSubject<SortOptions, Never>()
        let favoriteSubject = PassthroughSubject<Bool, Never>()
        let selectionSubject = PassthroughSubject<String, Never>()
        let favoriteCoinSubject = PassthroughSubject<UICoinModel, Never>()

        input = CoinListVMInput(
            loadMore: loadMoreSubject.eraseToAnyPublisher(),
            sortOption: sortOptionSubject.eraseToAnyPublisher(),
            isFavorite: favoriteSubject.eraseToAnyPublisher(),
            selection: selectionSubject.eraseToAnyPublisher(),
            favoriteCoin: favoriteCoinSubject.eraseToAnyPublisher()
        )
    }

    override func tearDown() {
        viewModel = nil
        localDataSource = nil
        mockDataSource = nil
        mockCoordinator = nil
        cancellables = nil
        super.tearDown()
    }

    func testInitialState() {
        let output = viewModel.transform(input: input)
        let expectation = XCTestExpectation(description: "Initial state is loading")

        output
            .sink { state in
                if case .loading = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)


        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadingCoins() {
        let output = viewModel.transform(input: input)
        let expectation = XCTestExpectation(description: "Loaded coins are returned")

        output
            .sink { state in
                if case let .loaded(coins) = state, coins.count == 1 {
                    XCTAssertEqual(coins.first?.name, "Bitcoin")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        loadMoreSubject.send(0)

        wait(for: [expectation], timeout: 10.0)
    }
}
