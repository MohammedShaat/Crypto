//
//  DetailView-VIewModel.swift
//  Crypto
//
//  Created by Mohammed on 7/7/26.
//

import Foundation


extension DetailView {
    @Observable
    class ViewModel {
        private let coinDetailService = CoinDetailService.shared
        let coin: Coin
        private(set) var loadingStatus: LoadingStatus = .idle
        private(set) var coinDetail: CoinDetail?
        private(set) var overviewStatistics = [Statistic]()
        private(set) var additionalStatistics = [Statistic]()
        
        private let notAvailable = "N/A"
        
        init(coin: Coin) {
            self.coin = coin
            
            Task {
                await loadCoinDetail()
            }

//            coinDetail = CoinDetail(id: "Bitcoin", symbol: "BTC", name: "Bitcoin", webSlug: "", blockTimeInMinutes: 20, hashingAlgorithm: "SSH", categories: [], hasSupplyBreakdown: true, description: Description(en: ""), links: Links(homepage: [], twitterScreenName: "", facebookUsername: "", telegramChannelIdentifier: "", subredditUrl: ""), lastUpdated: "")
//            loadingStatus = .success
//            setupStatistics()
        }
        
        private func loadCoinDetail() async {
            loadingStatus = .loading
            
            let result = await coinDetailService.fetchCoinDetail(for: coin.id)
            switch result {
            case .success(let detail):
                coinDetail = detail
                setupStatistics()
                loadingStatus = .success
            case .failure(let error):
                loadingStatus = .failure(error.localizedDescription)
            }
        }
        
        private func setupStatistics() {
            setupOverviewStatistics()
            setupAdditionalStatistics()
        }
        
        private func setupOverviewStatistics() {
            let price = Statistic(name: "Current Price", value: coin.currentPrice.asAbreviatedCurrency, percentage: coin.priceChangePercentage24h)
            let marketCapitalization = Statistic(name: "Market Capitalization", value: (coin.marketCap ?? 0).asAbreviatedCurrency, percentage: coin.marketCapChangePercentage24h)
            let rank = Statistic(name: "Rank", value: coin.rank.toString)
            let volume = Statistic(name: "Volume", value: (coin.totalVolume ?? 0).asAbreviatedCurrency)
            overviewStatistics.append(contentsOf: [price, marketCapitalization, rank, volume])
        }
        
        private func setupAdditionalStatistics() {
            let high24 = Statistic(name: "24 Hight", value: (coin.high24h ?? 0).asAbreviatedCurrency)
            let low24 = Statistic(name: "24 Low", value: (coin.low24h ?? 0).asAbreviatedCurrency)
            let priceChange = Statistic(name: "24 Price Change", value: (coin.priceChange24h ?? 0).asAbreviatedCurrency, percentage: coin.priceChangePercentage24h)
            let marketChange = Statistic(name: "24 Market Change", value: (coin.marketCapChange24h ?? 0).asAbreviatedCurrency, percentage: coin.marketCapChangePercentage24h)
            let blockTime = Statistic(name: "Block Time", value: coinDetail?.blockTimeInMinutes.toString ?? notAvailable)
            let hashingAlgorithm = Statistic(name: "Hashing Algorithm", value: coinDetail?.hashingAlgorithm ?? notAvailable)
            additionalStatistics.append(contentsOf: [high24, low24, priceChange, marketChange, blockTime, hashingAlgorithm])
        }
    }
}
