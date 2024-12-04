//
//  NetworkError.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .requestFailed(let error):
            return "Network request failed with error: \(error.localizedDescription)"
        case .invalidResponse:
            return "The response from the server was invalid."
        case .decodingFailed(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        }
    }
}
