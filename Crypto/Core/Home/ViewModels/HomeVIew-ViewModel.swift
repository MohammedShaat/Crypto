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
        var searchText = ""
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
        
        private let marketService = MarketService.shared
        private(set) var statistics = [Statistic]()
        
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
                    getStatistics(for: networkMarketResult.data)
                
                case .failure(let error):
                    print("Failed to fetch market statistics: \(error)")
                }
            }
        }
        
        private func getStatistics(for marketStatistics: MarketStatistics) {
            //            for (coin, value) in totalMarketCap {
            //                let statistic = Statistic(
            //                    name: coin,
            //                    value: value.asAbreviatedCurrency,
            //                    percentage: marketStatistics.marketCapPercentage[coin]
            //                )
            //                statistics.append(statistic)
            //            }
            
            let marketCap = Statistic(name: "Market Cap", value: marketStatistics.totalMarketCap["usd"] ?? 0, percentage: marketStatistics.marketCapChangePercentage24hUsd)
            
            let volume = Statistic(name: "24h Volume", value: marketStatistics.totalVolume["usd"] ?? 0, percentage: marketStatistics.marketCapPercentage["usd"])
            
            let btcDominance = Statistic(name: "BTC Dominance", value: marketStatistics.marketCapPercentage["btc"] ?? 0, percentage: marketStatistics.marketCapPercentage["btc"])
            
            let profile = Statistic(name: "Profile Value", value: 0)
            statistics.append(contentsOf: [marketCap, volume, btcDominance, profile])
        }
        
        func switchView() {
            activeView = activeView == .coins ? .profile : .coins
        }
        
        enum ActiveView {
            case coins, profile
        }
    }
}
