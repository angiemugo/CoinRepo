//
//  DataResponse.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

struct DataResponse<T: Decodable>: Decodable {
    let data: T
}

