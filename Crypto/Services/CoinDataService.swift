//
//  NetworkDataService.swift
//  Crypto
//
//  Created by Mohammed on 7/2/26.
///Users/mhmd/Documents/iOSProjects/Crypto/Crypto/Core/Home/ViewModels/HomeVIew-ViewModel.swift

import Foundation


struct CoinDataService {
    static let shared = CoinDataService()
    
    private init() { }
    
    func fetchCoins() async -> Result<[Coin], NetworkError> {
        await NetworkService.fetchData(
            from: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        )
    }
}
