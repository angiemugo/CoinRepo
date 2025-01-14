//
//  CoinHistoryResponse.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

struct CoinHistoryModel: Decodable {
    let price: String
    let timestamp: Double
}

struct CoinHistoryResponse: Decodable {
    let history: [CoinHistoryModel]
}
