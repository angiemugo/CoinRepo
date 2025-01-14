//
//  CoinDetailViewModelTests.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

import XCTest
@testable import CoinApp

final class CoinDetailViewModelTests: XCTestCase {
    var viewModel: CoinDetailViewModel!
    var localDataSource: LocalDataSource!

    override func setUp() {
        super.setUp()
        localDataSource = LocalDataSource()
        viewModel = CoinDetailViewModel(dataSource: localDataSource, coinId: "testCoin")
    }

    override func tearDown() {
        viewModel = nil
        localDataSource = nil
        super.tearDown()
    }

    func testLoadCoins_Success() async throws {
        // Act
        await viewModel.loadCoins()

        // Assert
        switch viewModel.coinDetailState {
        case .loaded(let coin):
            XCTAssertEqual(coin.name, "Bitcoin", "Expected coin name to be 'Bitcoin'.")
            XCTAssertFalse(coin.sparkline.isEmpty, "Expected sparkline data to be available.")
        default:
            XCTFail("Expected coinDetailState to be loaded with valid coin details.")
        }

        switch viewModel.chartDataState {
        case .loaded(let chartData):
            XCTAssertEqual(chartData.count, 24, "Expected chart data to contain 24 data points.")
            XCTAssertEqual(chartData.first?.y, 95347.88981554087, "Expected first chart data point to be '0.1'.")
        default:
            XCTFail("Expected chartDataState to be loaded with valid chart data.")
        }
    }

    func testLoadCoinHistory_Success() async throws {
        // Arrange
        let timePeriod = TimePeriod.twentyFourHours

        // Act
        await viewModel.loadCoinHistory(timePeriod: timePeriod)

        // Assert
        switch viewModel.chartDataState {
        case .loaded(let chartData):
            XCTAssertEqual(chartData.count, 49, "Expected chart data to contain 24 data points.")
            XCTAssertEqual(chartData.first?.y, 94593.30447107015, "Expected first chart data point to be '0.1'.")
        default:
            XCTFail("Expected chartDataState to be loaded with valid chart data.")
        }
    }

    func testLoadCoins_Error() async throws {
        let invalidDataSource = LocalDataSourceWithError()
        viewModel = CoinDetailViewModel(dataSource: invalidDataSource, coinId: "testCoin")

        // Act
        await viewModel.loadCoins()

        // Assert
        if case .error = viewModel.coinDetailState {
            // Success: Expected an error state for coinDetailState
        } else {
            XCTFail("Expected coinDetailState to be in error state.")
        }

        if case .error = viewModel.chartDataState {
            // Success: Expected an error state for chartDataState
        } else {
            XCTFail("Expected chartDataState to be in error state.")
        }
    }

    func testLoadCoinHistory_Error() async throws {
        let invalidDataSource = LocalDataSourceWithError()
        viewModel = CoinDetailViewModel(dataSource: invalidDataSource, coinId: "testCoin")
        let timePeriod: TimePeriod = .oneYear
        // Act
        await viewModel.loadCoinHistory(timePeriod: timePeriod)

        // Assert
        if case .error = viewModel.chartDataState {
            // Success: Expected an error state for chartDataState
        } else {
            XCTFail("Expected chartDataState to be in error state.")
        }
    }
}
