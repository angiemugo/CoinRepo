//
//  URLBuilder.swift
//  CoinApp
//
//  Created by Angie Mugo on 10/01/2025.
//

import Foundation

class URLBuilder {
    let base: URL

    init() {
        base = Network.baseURL
    }
    
    func url(path: CoinClientPaths, params: [String: String] = [:]) -> URL {
        guard let url = URL(string: path.rawValue, relativeTo: base) else {
            fatalError("Invalid path, unable to create a URL: \(path)")
        }
        
        return buildURL(url: url, params: params)
    }
    
    func url(path: CoinClientPaths, params: [String: String] = [:], urlArgs: CVarArg...) -> URL {
        let path = String(format: path.rawValue, arguments: urlArgs)
        guard let url = URL(string: path, relativeTo: base) else {
            fatalError("Invalid path, unable to create a URL: \(path)")
        }

        return buildURL(url: url, params: params)
    }

    private func buildURL(url: URL, params: [String: String]) -> URL {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            fatalError("Invalid url, unable to build components path")
        }

        if !params.isEmpty {
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        guard let result = components.url else {
            fatalError("Unable to create url from components (\(components)")
        }

        return result
    }
}
