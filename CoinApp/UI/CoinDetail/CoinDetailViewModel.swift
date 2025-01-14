//
//  CoinDetailVM.swift
//  CoinApp
//
//  Created by Angie Mugo on 09/01/2025.
//

import SwiftUI

enum CoinDetailLoadingState<T> {
    case loading
    case loaded(T)
    case error(Error)
}

class CoinDetailViewModel: ObservableObject {
    @Published var coinDetailState: CoinDetailLoadingState<CoinDetailModel> = .loading
    @Published var chartDataState: CoinDetailLoadingState<[PerformanceChartData]> = .loading
    let coinId: String
    let dataSource: DataSource

    init(dataSource: DataSource, coinId: String) {
        self.dataSource = dataSource
        self.coinId = coinId
    }

    @MainActor
    func loadCoins() async {
        coinDetailState = .loading
        chartDataState = .loading
         do {
             let coinDetail = try await dataSource.getCoinDetails(id: coinId)
             self.coinDetailState = .loaded(coinDetail.coin)
             let chartData = coinDetail.coin.sparkline.enumerated().map { (index, coinHistoryModel) in
                 PerformanceChartData(data: coinHistoryModel ?? "0", index: index)
             }
             self.chartDataState = .loaded(chartData)
         } catch {
             self.chartDataState = .error(error)
             self.coinDetailState = .error(error)
             debugPrint(error)
             return
         }
    }

    @MainActor
    func loadCoinHistory(timePeriod: TimePeriod) async {
        chartDataState = .loading
        do {
            let coinHistory = try await dataSource.getCoinHistory(id: coinId, timePeriod: timePeriod.rawValue)
            let chartData = coinHistory.history.map { data in
                return PerformanceChartData(performanceData: data)
            }
            self.chartDataState = .loaded(chartData)
        } catch {
            self.chartDataState = .error(error)
            debugPrint(error)
            return
        }
    }
}
