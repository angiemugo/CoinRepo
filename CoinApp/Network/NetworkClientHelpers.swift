//
//  NetworkClientHelpers.swift
//  CoinApp
//
//  Created by Angie Mugo on 10/01/2025.
//

import Foundation


enum CoinAppClientError: Error, Identifiable {
    var id: String {
          return UUID().uuidString
      }

    case genericError(Error)
    case apiError(message: String)
    case decodingError(Error)
    case unsupportedResponseError
    case builderError(message: String)
    case locationError(message: String)
}


enum NetworkClientHelpers {
    static func extractError(response: URLResponse?, error: Error?) -> CoinAppClientError? {
        if let error = error {
            return .genericError(error)
        }
        
        guard let response = response as? HTTPURLResponse else {
            return .unsupportedResponseError
        }
        
        if (400..<503).contains(response.statusCode) {
            return .apiError(message: response.debugDescription)
        }
        
        return nil
    }
}
