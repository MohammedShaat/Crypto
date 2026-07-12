//
//  CoinDetailService.swift
//  Crypto
//
//  Created by Mohammed on 7/7/26.
//

import Foundation

struct CoinDetailService {
    static let shared = CoinDetailService()
    
    private let baseURL = { (id: String) in
        "https://api.coingecko.com/api/v3/coins/\(id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
    }
    
    private init() {}
    
    func fetchCoinDetail(for id: String) async -> Result<CoinDetail, NetworkError> {
        await NetworkService.fetchDecodedData(from: baseURL(id))
    }
}
