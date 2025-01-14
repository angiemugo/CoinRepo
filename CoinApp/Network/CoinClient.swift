//
//  CoinClient.swift
//  CoinApp
//
//  Created by Angie Mugo on 10/01/2025.
//

import Foundation

final class CoinClient {
    let networkClient: NetworkClient
    let urlBuilder = URLBuilder()

    init(networkClient: NetworkClient? = nil) {
        self.networkClient = networkClient ?? DefaultNetworkClient()
    }

    func headers() -> Network.HTTPHeaders {
        [:]
    }
}
