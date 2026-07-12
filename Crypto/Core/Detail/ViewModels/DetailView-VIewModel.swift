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
        private var coinDetail: CoinDetail?
        let coin: Coin
        private(set) var loadingStatus: LoadingStatus = .idle
        private(set) var overviewStatistics = [Statistic]()
        private(set) var additionalStatistics = [Statistic]()
        private(set) var description: String?
        private(set) var websiteUrl: String?
        private(set) var redditUrl: String?
        
        private let notAvailable = "N/A"
        private(set) var progress = 0.0
        private(set) var isDescriptionExpanded = false
        private var tasks: [Task<Void, Never>] = []
        
        init(coin: Coin) {
            self.coin = coin
            
            let coinDetailTask = Task {
                await loadCoinDetail()
            }
            tasks.append(coinDetailTask)
        }
        
        private func loadCoinDetail() async {
            loadingStatus = .loading
            
            let result = await coinDetailService.fetchCoinDetail(for: coin.id)
            switch result {
            case .success(let detail):
                coinDetail = detail
                setupDetails()
                loadingStatus = .success
            case .failure(let error):
                loadingStatus = .loadingFailed(error.localizedDescription)
            }
        }
        
        func incrementProgress() {
            progress = 1
        }
        
        func expandDescription() {
            isDescriptionExpanded.toggle()
        }
        
        private func setupDetails() {
            setupOverviewStatistics()
            setupAdditionalStatistics()
            description = coinDetail?.description.en
            websiteUrl = coinDetail?.links.homepage.first
            redditUrl = coinDetail?.links.subredditUrl
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
        
        func cancelTasks() {
            tasks.forEach { $0.cancel() }
            tasks.removeAll()
        }
    }
}
