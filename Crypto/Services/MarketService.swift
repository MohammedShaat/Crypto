//
//  MarketService.swift
//  Crypto
//
//  Created by Mohammed on 7/4/26.
//

import Foundation

struct MarketService {
    static let shared = MarketService()
    
    private let apiURL = "https://api.coingecko.com/api/v3/global"
    
    private init() { }
    
    func fetchMarketStatistics() async -> Result<MarketResult, NetworkError> {
        await NetworkService.fetchDecodedData(from: apiURL)
    }
}
