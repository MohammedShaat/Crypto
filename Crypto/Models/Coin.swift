//
//  Coin.swift
//  Crypto
//
//  Created by Mohammed on 6/30/26.
//

import Foundation

struct Coin: Identifiable, Codable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double?
    let marketCapRank: Int?
    let fullyDilutedValuation: Double?
    let totalVolume: Double?
    let high24h: Double?
    let low24h: Double?
    let priceChange24h: Double?
    let priceChangePercentage24h: Double?
    let marketCapChange24h: Double?
    let marketCapChangePercentage24h: Double?
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7d: SparkLineIn7d?
    let currentHoldings: Double?
    
    var totalCurrentHodldings: Double {
        currentPrice * (currentHoldings ?? 0)
    }
    
    var rank: Int {
        Int(marketCapRank ?? 0)
    }
    
    func updateHoldings(amount: Double) -> Coin {
        Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24h: high24h, low24h: low24h, priceChange24h: priceChange24h, priceChangePercentage24h: priceChangePercentage24h, marketCapChange24h: marketCapChange24h, marketCapChangePercentage24h: marketCapChangePercentage24h, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7d: sparklineIn7d, currentHoldings: (currentHoldings ?? 0) + amount)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7d = "sparkline_in_7d"
        case currentHoldings
    }
    
    
    struct SparkLineIn7d: Codable {
        let price: [Double]
    }
    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        symbol = try container.decode(String.self, forKey: .symbol)
//        name = try container.decode(String.self, forKey: .name)
//        image = try container.decode(String.self, forKey: .image)
//        currentPrice = try container.decode(Double.self, forKey: .currentPrice)
//        priceChangePercentage24 = try container.decode(Double.self, forKey: .priceChangePercentage24)
//        rank = try container.decode(Int.self, forKey: .rank)
//    }
//
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(symbol, forKey: .symbol)
//        try container.encode(name, forKey: .name)
//        try container.encode(image, forKey: .image)
//        try container.encode(currentPrice, forKey: .currentPrice)
//        try container.encode(priceChangePercentage24, forKey: .priceChangePercentage24)
//        try container.encode(rank, forKey: .rank)
//    }
}


// JSON API
/*
 [
     {
         "id": "bitcoin",
         "symbol": "btc",
         "name": "Bitcoin",
         "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
         "current_price": 58611,
         "market_cap": 1175182750614,
         "market_cap_rank": 1,
         "fully_diluted_valuation": 1175182750614,
         "total_volume": 31363890719,
         "high_24h": 60492,
         "low_24h": 58734,
         "price_change_24h": -1283.3512139652667,
         "price_change_percentage_24h": -2.14267,
         "market_cap_change_24h": -26368723933.375732,
         "market_cap_change_percentage_24h": -2.19456,
         "circulating_supply": 20050178,
         "total_supply": 20050178,
         "max_supply": 21000000,
         "ath": 126080,
         "ath_change_percentage": -53.51243,
         "ath_date": "2025-10-06T18:57:42.558Z",
         "atl": 67.81,
         "atl_change_percentage": 86336.13558,
         "atl_date": "2013-07-06T00:00:00.000Z",
         "roi": null,
         "last_updated": "2026-06-30T12:49:35.780Z",
         "sparkline_in_7d": {
         "price": [
         62199.8784487437,
         62383.94741826511,
         62457.865612986134,
         62378.52994283749,
         62492.81701127148,
         62300.737372444346,
         62171.87002961892,
        ]
    }
 }
 */
