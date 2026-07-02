//
//  NetworkService.swift
//  Crypto
//
//  Created by Mohammed on 7/2/26.
//

import Foundation

struct NetworkService {
    private init() { }
    
    static func fetchData<Value: Decodable>(from url: String) async -> Result<Value, NetworkError> {
        
        guard let url = URL(string: url) else {
            print("Invalid URL: \(url)")
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                print("Bad response: \(response)")
                return .failure(.badResponse)
            }
            
            let decodedData = try JSONDecoder().decode(Value.self, from: data)
            return .success(decodedData)
            
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
            print(error)
            return .failure(.unknown(error))
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case badResponse
    case unknown(Error)
}
