//
//  CoinDetailModel.swift
//  CoinApp
//
//  Created by Angie Mugo on 09/01/2025.
//

struct CoinDetailModel: Decodable {
    let name: String
    let symbol: String
    let description: String
    let sparkline: [String?]
    let price: String
    let rank: Int
    let numberOfExchanges: Int
    let allTimeHigh: AllTimeHigh
    let marketCap: String
    let tags: [String]
    let iconUrl: String
    let change: String
    let tradingVolume: String

    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case description
        case sparkline
        case price
        case rank
        case numberOfExchanges
        case allTimeHigh
        case marketCap
        case tags
        case iconUrl
        case change
        case tradingVolume = "24hVolume"
    }
}

struct AllTimeHigh: Decodable {
    let timestamp: Int
    let price: String
}

struct CoinDetailResponse: Decodable {
    let coin: CoinDetailModel
}
