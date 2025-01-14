//
//  ErrorView.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

import SwiftUI

struct ErrorView: View {
    let error: CoinAppClientError?
    @State private var errorMessage: String = ""

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("Error Occurred")
                .font(.headline)
                .foregroundColor(.red)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .padding()
        .onAppear {
            extractError()
        }
    }

    func extractError() {
        guard let error = error else { return }
        switch error {
        case .genericError(let error):
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        case .apiError(let message):
            errorMessage = "API Error: \(message)"
        case .decodingError(let error):
            errorMessage = "Decoding Error: \(error.localizedDescription)"
        case .unsupportedResponseError:
            errorMessage = "Unsupported Response Error."
        case .builderError(let message):
            errorMessage = "Builder Error: \(message)"
        case .locationError(let message):
            errorMessage = "Location Error: \(message)"
        }
    }
}

struct CustomError: LocalizedError {
    var errorDescription: String?

    init(description: String) {
        self.errorDescription = description
    }
}

#Preview {
    ErrorView(error: CoinAppClientError.apiError(message: "Error"))
}

