//
//  RemoteDataSource.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

protocol DataSource {
    func getCoins(offset: Int) async throws -> [CoinModel]
    func getCoinDetails(id: String) async throws -> CoinDetailResponse
    func getCoinHistory(id: String, timePeriod: String) async throws -> CoinHistoryResponse
}

class RemoteDataSource: DataSource {
    let networkClient: NetworkClient
    let urlBuilder = URLBuilder()
    let headers: Network.HTTPHeaders

    init(_ client: CoinClient) {
        self.networkClient = client.networkClient
        self.headers = networkClient.headers
    }

    func getCoins(offset: Int = 0) async throws -> [CoinModel] {
        let result: DataResponse<CoinResponse> = try await networkClient.get(urlBuilder.url(path: CoinClientPaths.CoinList, params: ["offset": "\(offset)",
                                                                                                                                     "limit": "20"]),
                                                                             headers: headers)
        return result.data.coins
    }

    func getCoinDetails(id: String) async throws -> CoinDetailResponse {
        let result: DataResponse<CoinDetailResponse> = try await networkClient.get(urlBuilder.url(path: CoinClientPaths.CoinDetail,
                                                                                                  urlArgs: id),

                                                                                headers: headers)
        return result.data
    }

    func getCoinHistory(id: String,
                        timePeriod: String = TimePeriod.twentyFourHours.rawValue) async throws -> CoinHistoryResponse {
        let result: DataResponse<CoinHistoryResponse> =
        try await networkClient.get(urlBuilder.url(path:CoinClientPaths.coinPriceHistory,
                                                   params: ["timePeriod": timePeriod],
                                                   urlArgs: id),
                                    headers: headers)
        return result.data
    }
}
