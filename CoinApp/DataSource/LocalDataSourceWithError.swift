//
//  LocalDataSourceWithError.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

import Foundation

class LocalDataSourceWithError: DataSource {
    enum LocalDataSourceError: Error {
        case simulatedError
    }

    func getCoins(offset: Int = 0) async throws -> [CoinModel] {
        throw LocalDataSourceError.simulatedError
    }

    func getCoinDetails(id: String) async throws -> CoinDetailResponse {
        throw LocalDataSourceError.simulatedError
    }

    func getCoinHistory(id: String, timePeriod: String) async throws -> CoinHistoryResponse {
        throw LocalDataSourceError.simulatedError
    }
}
