//
//  JsonLocalDataSource.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//

import Foundation

class JsonLocalDataSource {
    /// Reads a JSON file and decodes it into a specified Decodable type.
    /// - Parameter fileName: The name of the JSON file (without extension).
    /// - Returns: A decoded instance of the specified type.
    /// - Throws: An error if the file cannot be found or decoding fails.
    func read<T: Decodable>(_ fileName: String) async throws -> T {
        guard let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            throw CoinAppError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}

enum CoinAppError: Error {
    case fileNotFound
}
