//
//  CoinClient.swift
//  CoinApp
//
//  Created by Angie Mugo on 10/01/2025.
//

import Foundation

final class CoinClient {
    private var apiKey: String? = nil
    let networkClient: NetworkClient
    let urlBuilder = URLBuilder()

    init(apiKey: String,
        networkClient: NetworkClient? = nil) {
        self.apiKey = apiKey
        self.networkClient = networkClient ?? DefaultNetworkClient(apiKey)
    }

    func headers() -> Network.HTTPHeaders {
        [:]
    }
}
