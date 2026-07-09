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
        
        init(coin: Coin) {
            self.coin = coin
            
            Task {
                                await loadCoinDetail()
            }
            
//            coinDetail = CoinDetail(id: "Bitcoin", symbol: "BTC", name: "Bitcoin", webSlug: "", blockTimeInMinutes: 20, hashingAlgorithm: "SSH", categories: [], hasSupplyBreakdown: true, description: Description(en: "Bitcoin is the world's first decentralized cryptocurrency, created in 2009 by the pseudonymous Satoshi Nakamoto. It enables peer-to-peer electronic cash transactions without intermediaries like banks or governments, operating on a blockchain secured by Proof of Work mining and the SHA-256 cryptographic algorithm. \n\nWith a fixed supply cap of 21 million coins and programmatic halvings every four years that reduce miner rewards, Bitcoin is designed as a deflationary digital asset often called \"digital gold.\" Its value stems from solving the double-spending problem without trusted intermediaries, creating the first truly scarce digital asset with censorship resistance and permissionless access that no government, corporation, or individual can control.\n\nBitcoin operates as a decentralized peer-to-peer network where transactions are recorded on a public ledger called the blockchain, distributed across thousands of computers globally. Transactions are grouped into blocks added approximately every 10 minutes through mining, where specialized computers compete to solve complex mathematical puzzles. \n\nBitcoin has achieved mainstream adoption through multiple vectors. The January 2024 SEC approval of 11 spot Bitcoin ETFs opened Bitcoin investment to traditional finance participants, and corporations like Strategy (formerly MicroStrategy) are using Bitcoin as a treasury reserve asset to protect against currency debasement, offering MSTR holders amplified exposure to Bitcoin. \n\nThe Bitcoin ecosystem continues to evolve with innovations like Ordinals, which emerged in January 2023 to enable NFT-like functionality directly on Bitcoin, and BRC-20 tokens, an experimental standard for creating fungible tokens using Ordinal inscriptions. BTCFi (Bitcoin Finance) represents emerging financial applications extending beyond Bitcoin's traditional role, with protocols like Babylon allowing Bitcoin holders to stake BTC to secure Proof of Stake chains. "
//), links: Links(homepage: [], twitterScreenName: "", facebookUsername: "", telegramChannelIdentifier: "", subredditUrl: ""), lastUpdated: "")
//            loadingStatus = .success
//            setupDetails()
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
                loadingStatus = .failure(error.localizedDescription)
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
    }
}
