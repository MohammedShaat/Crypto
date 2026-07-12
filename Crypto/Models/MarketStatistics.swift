//
//  MarketStatistics.swift
//  Crypto
//
//  Created by Mohammed on 7/4/26.
//

import Foundation

struct MarketResult: Codable {
    let data: MarketStatistics
}

struct MarketStatistics: Codable {
    let activeCryptocurrencies: Int
    let upcomingIcos: Int
    let ongoingIcos: Int
    let endedIcos: Int
    let markets: Int
    let totalMarketCap: [String: Double]
    let totalVolume: [String: Double]
    let marketCapPercentage: [String: Double]
    let marketCapChangePercentage24hUsd: Double
    let volumeChangePercentage24hUsd: Double
    let updated_at: Int
    
    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24hUsd = "market_cap_change_percentage_24h_usd"
        case volumeChangePercentage24hUsd = "volume_change_percentage_24h_usd"
        case updated_at
    }
}
