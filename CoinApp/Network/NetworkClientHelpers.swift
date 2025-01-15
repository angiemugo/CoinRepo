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
}
