//
//  PlistDataSource.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

import Foundation

func fetchAPIKey() throws -> String {
    if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
       let secrets = NSDictionary(contentsOfFile: path),
       let apiKey = secrets["API_KEY"] as? String {
        return apiKey
    } else {
        throw(CoinAppClientError.genericError("Failed to load API Key." as! Error))
    }
}
