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
        private let networkService = CoinDataService.shared
        private(set) var coins = [Coin]()
        private(set) var activeView: ActiveView = .coins
        private(set) var loadingStatus: LoadingStatus = .idle
        
        init() {
            Task {
                await loadCoins()
            }
        }
        
        func loadCoins() async  {
            loadingStatus = .loading
            
            let result = await networkService.fetchData()
            switch result {
            case .success(let networkCoins):
                coins = networkCoins
                loadingStatus = .success
                
            case .failure(let error):
                switch error {
                case .invalidURL:
                    loadingStatus = .failure("Invalid URL")
                case .badResponse:
                    loadingStatus = .failure("Bad Response")
                case .unknown(_):
                    loadingStatus = .failure("Unkown error")
                }
            }
        }
        
        func switchView() {
            activeView = activeView == .coins ? .profile : .coins
        }
        
        enum ActiveView {
            case coins, profile
        }
        
        enum LoadingStatus {
            case idle, loading, success, failure(String)
        }
    }
}
