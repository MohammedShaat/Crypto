//
//  HomeView-ViewModel.swift
//  Crypto
//
//  Created by Mohammed on 7/1/26.
//

import Foundation
import SwiftData

extension HomeView {
    @Observable
    class ViewModel {
        private let CoinService = CoinDataService.shared
        private var allCoins = [Coin]() {
            didSet {
                updateCoins()
                updateProfileCoins()
            }
        }
        private(set) var coins = [Coin]()
        var searchText = "" {
            didSet {
                updateCoins()
            }
        }
        
        private let marketService = MarketService.shared
        private var marketStatistics: MarketStatistics? {
            didSet {
                updateStatistics()
            }
        }
        var statistics = [Statistic]()
        
        private let profileCoinService: ProfileCoinService
        private var profileLocalCoins = [LocalCoin]() {
            didSet {
                updateProfileCoins()
                updateStatistics()
            }
        }
        var profileCoins = [Coin]()
        
        private(set) var activeView: ActiveView = .coins
        private(set) var loadingStatus: LoadingStatus = .idle
        private(set) var refreshDegree = 0.0
        
        var showingEditProfile = false
        var tappedCoin: Coin?
        var newHoldings: Double?
        var totalHoldings: Double {
            (tappedCoin?.currentPrice ?? 0) * (newHoldings ?? 0)
        }
        var showingSaveButton = false
        private(set) var showingSaveIcon = false
        
        
        init(context: ModelContext) {
            profileCoinService = ProfileCoinService(context: context)
            Task {
                async let loadCoinsOp = loadCoins()
                async let loadMarketStatisticsOp = loadMarketStatistics()
                _ = await (loadCoinsOp, loadMarketStatisticsOp)
                loadProfileCoins()
            }
        }
        
        private func updateCoins() {
            print("*{coins}")
            if searchText.isEmpty {
                coins = allCoins
            } else {
                coins = allCoins.filter { coin in
                    coin.name.localizedStandardContains(searchText) || coin.symbol.localizedStandardContains(searchText)
                }
            }
        }
        
        private func updateProfileCoins() {
            print("*{profileCoins}")
            profileCoins = profileLocalCoins.compactMap { localCoin in
                allCoins.first {
                    $0.id == localCoin.id
                }?.updateHoldings(amount: localCoin.currentHoldings)
            }
        }
        
        private func loadCoins(status: LoadingStatus = .loading) async  {
            loadingStatus = status
            if status == .refreshing {
                refreshDegree += 360
            }
            
            let result = await CoinService.fetchCoins()
            switch result {
            case .success(let networkCoins):
                allCoins = networkCoins
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
        
        private func loadMarketStatistics() async {
            let result = await marketService.fetchMarketStatistics()
            switch result {
            case .success(let networkMarketResult):
                marketStatistics = networkMarketResult.data
                
            case .failure(let error):
                print("Failed to fetch market statistics: \(error)")
            }
        }
        
        private func updateStatistics() {
            print("*{statistics}")
            guard let marketStatistics else { return  }
            
            var newStatistics = [Statistic]()
            let marketCap = Statistic(name: "Market Cap", value: marketStatistics.totalMarketCap["usd"] ?? 0, percentage: marketStatistics.marketCapChangePercentage24hUsd)
            
            let volume = Statistic(name: "24h Volume", value: marketStatistics.totalVolume["usd"] ?? 0, percentage: marketStatistics.marketCapPercentage["usd"])
            
            let btcDominance = Statistic(name: "BTC Dominance", value: marketStatistics.marketCapPercentage["btc"] ?? 0, percentage: marketStatistics.marketCapPercentage["btc"])
            
            let newProfileValue = profileCoins.map { $0.totalCurrentHodldings }.reduce(0, +)
            let oldProfileValue = profileCoins.map {
                // Get the previous value
                $0.totalCurrentHodldings / (100 + ($0.priceChangePercentage24h ?? 0)) * 100
            }.reduce(0, +)
            let profilePercentage = (newProfileValue - oldProfileValue) / oldProfileValue * 100
            let profile = Statistic(name: "Profile Value", value: newProfileValue, percentage: profilePercentage)
            
            newStatistics.append(contentsOf: [marketCap, volume, btcDominance, profile])
            statistics = newStatistics
        }
        
        private func loadProfileCoins() {
            let result = profileCoinService.fetchCoins()
            switch result {
            case .success(let localCoins):
                profileLocalCoins = localCoins
            case .failure:
                break
            }
        }
        
        func refresh() async {
            await loadCoins(status: .refreshing)
            await loadMarketStatistics()
        }
        
        func switchView() {
            activeView = activeView == .coins ? .profile : .coins
        }
        
        func topLeadingButtonTapped() {
            if activeView == .profile {
                showingEditProfile.toggle()
            }
        }
        
        func coinTapped(_ coin: Coin) {
            tappedCoin = coin
            newHoldings = coin.currentHoldings
        }
        
        func newHoldingsChanged() {
            guard let newHoldings else { return }
            showingSaveButton = newHoldings != tappedCoin?.currentHoldings
        }
        
        func save() {
            let emptyTappedCoin = { self.tappedCoin = nil }
            guard let tappedCoin, let newHoldings else { return }
            
            // The coin is already added to profile
            if let localCoin = profileLocalCoins.first(where: { $0.id == tappedCoin.id }) {
                if newHoldings == 0 {
                    profileCoinService.deleteCoin(localCoin)
                } else {
                    localCoin.currentHoldings = newHoldings
                }
            // Add new coin to profile
            } else {
                let newLocalCoin = LocalCoin(id: tappedCoin.id, currentHoldings: newHoldings)
                profileCoinService.addCoin(newLocalCoin)
            }
            // Refetch profile coins
            loadProfileCoins()
            
            showingSaveButton = false
            showingSaveIcon = true
            emptyTappedCoin()
            
            Task {
                try? await Task.sleep(for: .seconds(1))
                showingSaveIcon = false
            }
        }
        
        enum ActiveView {
            case coins, profile
        }
    }
}
