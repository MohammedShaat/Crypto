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
        private(set) var activeView: ActiveView = .coins

        private let CoinService = CoinDataService.shared
        private var _coins = [Coin]()
        var coins: [Coin] {
            if searchText.isEmpty {
                return _coins
            } else {
                return _coins.filter { coin in
                    coin.name.localizedStandardContains(searchText) || coin.symbol.localizedStandardContains(searchText)
                }
            }
        }
        private(set) var loadingStatus: LoadingStatus = .idle
        var searchText = ""
        
        private let marketService = MarketService.shared
        private(set) var marketStatistics: MarketStatistics?
        
        init() {
            Task {
                await loadCoins()
            }
            
            loadMarketStatistics()
        }
        
        func loadCoins() async  {
            loadingStatus = .loading
            
            let result = await CoinService.fetchCoins()
            switch result {
            case .success(let networkCoins):
                _coins = networkCoins
                loadingStatus = .success
                
            case .failure(let error):
                switch error {
                case .invalidURL:
                    loadingStatus = .failure("Invalid URL")
                case .badResponse:
                    loadingStatus = .failure("Bad Response")
                case .unknown:
                    loadingStatus = .failure("Unexpected error occured")
                }
            }
        }
        
        func loadMarketStatistics() {
            Task {
                let result = await marketService.fetchMarketStatistics()
                switch result {
                case .success(let networkMarketResult):
                    print(networkMarketResult)
                    marketStatistics = networkMarketResult.data
                
                case .failure(let error):
                    print("Failed to fetch market statistics: \(error)")
                }
            }
        }
        
        func switchView() {
            activeView = activeView == .coins ? .profile : .coins
        }
        
        enum ActiveView {
            case coins, profile
        }
    }
}
