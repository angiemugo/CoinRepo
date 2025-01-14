//
//  CoinModel.swift
//  CoinApp
//
//  Created by Angie Mugo on 09/01/2025.
//

struct CoinModel: Decodable {
    let id: String
    let name: String
    let price: String
    let currentPerformance: String
    let iconUrl: String

    enum CodingKeys: String, CodingKey {
        case name, iconUrl, price
        case currentPerformance = "24hVolume"
        case id = "uuid"
    }
}

struct CoinResponse: Decodable {
    let coins: [CoinModel]
}
