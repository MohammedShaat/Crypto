//
//  NetworkService.swift
//  Crypto
//
//  Created by Mohammed on 7/2/26.
//

import Foundation

struct NetworkService {
    private init() { }
    
    static func fetchData(from url: String) async -> Result<Data, NetworkError> {
        
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
            
            return .success(data)
            
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
            print(error)
            return .failure(.unknown(error))
        }
    }
    
    static func fetchDecodedData<T: Decodable>(from url: String) async -> Result<T, NetworkError> {
        let result = await fetchData(from: url)
        switch result {
        case .success(let data):
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(.unknown(error))
            }
            
        case .failure(let error):
            return .failure(error)
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case badResponse
    case unknown(Error)
}
