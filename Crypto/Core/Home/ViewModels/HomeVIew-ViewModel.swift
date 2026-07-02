//
//  HomeView-ViewModel.swift
//  Crypto
//
//  Created by Mohammed on 7/1/26.
//

import Foundation

extension HomeView {
    @Observable
    class ViewModel {
        private(set) var coins = [Coin]()
        private(set) var activeView: ActiveView = .coins
        private(set) var loadingStatus: LoadingStatus = .idle
        
        init() {
            Task {
                await loadCoins()
            }
        }
        
        func switchView() {
            activeView = activeView == .coins ? .profile : .coins
        }
        
        private func loadCoins() async {
            loadingStatus = .loading
            
            guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
                
                loadingStatus = .failure("Invalid URL")
                print("Invalid URL")
                return
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    loadingStatus = .failure("Bad response")
                    print("Bad response: \(response)")
                    return
                }
                
                coins = try JSONDecoder().decode([Coin].self, from: data)
                loadingStatus = .success
                print(coins.count)
            } catch {
                loadingStatus = .failure(error.localizedDescription)
                print("Failed to load data: \(error.localizedDescription)")
                print(error)
            }
        }
        
        enum ActiveView {
            case coins, profile
        }
        
        enum LoadingStatus {
            case idle, loading, success, failure(String)
        }
    }
}
