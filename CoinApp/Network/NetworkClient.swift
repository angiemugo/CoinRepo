//
//  DefaultNetworkClient.swift
//  CoinApp
//
//  Created by Angie Mugo on 10/01/2025.
//

import Foundation

enum Network {
    typealias HTTPHeaders = [String: String]
    
    static let baseURL = URL(string: "https://api.coinranking.com/2/")!

    enum HTTPMethod: String {
        case GET
    }
    
    enum Errors: Error {
        case HTTPError(code: Int)
        case genericError(Error)
    }
}

protocol NetworkClient: AnyObject {
    var headers: Network.HTTPHeaders { get }
    
    func get<T: Decodable>(_ url: URL, headers: Network.HTTPHeaders?) async throws -> T
}

class DefaultNetworkClient: NetworkClient {
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let defaultHeaders: Network.HTTPHeaders
    
    init(_ apiKey: String? = nil) {
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        var headers = [String:String]()
        if let apiKey = apiKey {
            headers["Authorisation"] = "Bearer \(apiKey)"
        }
        defaultHeaders = headers
    }
    
    var headers: Network.HTTPHeaders {
        defaultHeaders
    }
    
    func get<T: Decodable>(_ url: URL, headers: Network.HTTPHeaders? = nil) async throws -> T {
        let request = buildRequest(method: .GET, url: url, headers: headers)
        return try await executeRequest(request: request)
    }
    
    private func initRequest(url: URL, headers: Network.HTTPHeaders? = [:]) -> URLRequest {
        let allHeaders = defaultHeaders.merging(headers ?? [:]) { (_, new) in
            new
        }
        var request = URLRequest(url: url)
        for item in allHeaders {
            request.setValue(item.value, forHTTPHeaderField: item.key)
        }
        
        return request
    }
    
    private func buildRequest(method: Network.HTTPMethod, url: URL, headers: Network.HTTPHeaders?) -> URLRequest {
        var request = initRequest(url: url, headers: headers)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    private func executeRequest<T: Decodable>(request: URLRequest) async throws -> T {
        DebugEnvironment.log.debug("Request: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        let (data, _): (Data, URLResponse)
        do {
            (data, _) = try await URLSession.shared.data(for: request)
            DebugEnvironment.log.trace(String(data: data, encoding: .utf8) ?? "")
        } catch {
            let error = NetworkClientHelpers.extractError(response: nil, error: error)
            throw error ?? .unsupportedResponseError
        }

        do {
            DebugEnvironment.log.trace(String(data: data, encoding: .utf8) ?? "")
            let result = try self.decoder.decode(T.self, from: data)
            return result
        } catch let decodingError as Swift.DecodingError {
            DebugEnvironment.log.trace(String(data: data, encoding: .utf8) ?? "")
            let errorModel = try self.decoder.decode(ErrorModel.self, from: data)
        throw CoinAppClientError.apiError(message: "Failed to decode response into model: \(errorModel.message)")
        } catch {
            // If even ErrorModel decoding fails, rethrow the original decoding error
            throw CoinAppClientError.decodingError(CoinAppClientError.decodingError(error))
        }
    }
}

struct ErrorModel: Decodable {
    let message: String
}
