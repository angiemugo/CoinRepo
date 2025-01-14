//
//  MockLocalDataSource.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

class MockLocalDataSource: LocalDataSource {
    override func getCoins(offset: Int) async throws -> [CoinModel] {
        return [
            CoinModel(id: "1", name: "Bitcoin", price: "60000", currentPerformance: "5.0", iconUrl: "")
        ]
    }
}
