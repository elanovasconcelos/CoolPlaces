//
//  NetworkService.swift
//  CoolPlaces
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Codable>(endpoint: APIEndpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "https://private-anon-0900b74ad0-practical3.apiary-mock.com"
    
    init() {
        let memoryCapacity = 10 * 1024 * 1024 // 10 MB
        let diskCapacity = 50 * 1024 * 1024 // 50 MB
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myCache")
        
        URLCache.shared = urlCache
    }
    
    func fetch<T: Codable>(endpoint: APIEndpoint) async throws -> T {
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        urlComponents.path += endpoint.path
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.cachePolicy = .returnCacheDataElseLoad
        
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for : request)
        
        try validateResponse(response)
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            print(error)
            throw NetworkError.decodingFailed(error)
        }
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
    }
}
