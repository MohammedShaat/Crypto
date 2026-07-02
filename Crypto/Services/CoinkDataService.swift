//
//  NetworkDataService.swift
//  Crypto
//
//  Created by Mohammed on 7/2/26.
///Users/mhmd/Documents/iOSProjects/Crypto/Crypto/Core/Home/ViewModels/HomeVIew-ViewModel.swift

import Foundation


struct CoinDataService {
    static let shared = CoinDataService()
    
    private init() {
    }
    
    func fetchData() async -> Result<[Coin], NetworkError> {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
            
            print("Invalid URL")
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Bad response: \(response)")
                return .failure(.badResponse)
            }
            let coins = try JSONDecoder().decode([Coin].self, from: data)
            print(coins.count)
            return .success(coins)
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
            print(error)
            return .failure(.unknown(error))
        }
    }
    
    enum NetworkError: Error {
        case invalidURL
        case badResponse
        case unknown(Error)
    }
}
