//
//  LocalDataSource.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

class LocalDataSource: DataSource {
    func getCoins(offset: Int = 0) async throws -> [CoinModel] {
        let jsonLocalDataSource = JsonLocalDataSource()
        let data: DataResponse<CoinResponse> = try await jsonLocalDataSource.read("coins")
        return data.data.coins
    }
    
    func getCoinDetails(id: String) async throws -> CoinDetailResponse {
        let jsonLocalDataSource = JsonLocalDataSource()
        let coinDetail: DataResponse<CoinDetailResponse> = try await jsonLocalDataSource.read("coinDetail")
        return coinDetail.data
    }

    func getCoinHistory(id: String, timePeriod: String) async throws -> CoinHistoryResponse {
        let jsonLocalDataSource = JsonLocalDataSource()
        let coinHistory: DataResponse<CoinHistoryResponse> = try await jsonLocalDataSource.read("coinHistory")
        return coinHistory.data
    }
}
