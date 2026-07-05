//
//  Preview.swift
//  Crypto
//
//  Created by Mohammed on 7/1/26.
//

import Foundation
import SwiftUI

extension Preview {
    #if DEBUG
    static let coins = [
        Coin(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
            currentPrice: 58611,
            marketCap: 1175182750614,
            marketCapRank: 1,
            fullyDilutedValuation: 1175182750614,
            totalVolume: 31363890719,
            high24h: 60492,
            low24h: 58734,
            priceChange24h: -1283.3512139652667,
            priceChangePercentage24h: -2.14267,
            marketCapChange24h: -26368723933.375732,
            marketCapChangePercentage24h: -2.19456,
            circulatingSupply: 20050178,
            totalSupply: 20050178,
            maxSupply: 21000000,
            ath: 126080,
            athChangePercentage: -53.51243,
            athDate: "2025-10-06T18:57:42.558Z",
            atl: 67.81,
            atlChangePercentage: 86336.13558,
            atlDate: "2013-07-06T00:00:00.000Z",
            lastUpdated: "2026-06-30T12:49:35.780Z",
            sparklineIn7d: Coin.SparkLineIn7d(price: [
                62199.8784487437,
                62383.94741826511,
                62457.865612986134,
                // ...
                59290.66415548365
            ]),
            currentHoldings: 2
        ),

        Coin(
            id: "ethereum",
            symbol: "eth",
            name: "Ethereum",
            image: "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
            currentPrice: 1558.16,
            marketCap: 188043397016,
            marketCapRank: 2,
            fullyDilutedValuation: 188043397016,
            totalVolume: 11403699990,
            high24h: 1630.03,
            low24h: 1559.22,
            priceChange24h: -16.89333416950103,
            priceChangePercentage24h: -1.07256,
            marketCapChange24h: -2114131078.1890259,
            marketCapChangePercentage24h: -1.11178,
            circulatingSupply: 120683442.9924438,
            totalSupply: 120683442.9924438,
            maxSupply: nil,
            ath: 4946.05,
            athChangePercentage: -68.49695,
            athDate: "2025-08-24T19:21:03.333Z",
            atl: 0.432979,
            atlChangePercentage: 359768.86529,
            atlDate: "2015-10-20T00:00:00.000Z",
            lastUpdated: "2026-06-30T12:49:36.271Z",
            sparklineIn7d: Coin.SparkLineIn7d(price: [
                1658.682806066182,
                1652.8153262560757,
                1659.723330760854,
                // ...
                1583.336870342522
            ]),
            currentHoldings: 1.5
        ),

        Coin(
            id: "tether",
            symbol: "usdt",
            name: "Tether",
            image: "https://coin-images.coingecko.com/coins/images/325/large/Tether.png?1696501661",
            currentPrice: 0.998376,
            marketCap: 184690402921,
            marketCapRank: 3,
            fullyDilutedValuation: 190148463017,
            totalVolume: 51473556313,
            high24h: 0.998648,
            low24h: 0.998229,
            priceChange24h: -0.000244317116119275,
            priceChangePercentage24h: -0.02447,
            marketCapChange24h: -1385836066.5212097,
            marketCapChangePercentage24h: -0.74477,
            circulatingSupply: 184990940108.3242,
            totalSupply: 190457881824.0062,
            maxSupply: nil,
            ath: 1.32,
            athChangePercentage: -24.54169,
            athDate: "2018-07-24T00:00:00.000Z",
            atl: 0.572521,
            atlChangePercentage: 74.38406,
            atlDate: "2015-03-02T00:00:00.000Z",
            lastUpdated: "2026-06-30T12:49:29.221Z",
            sparklineIn7d: Coin.SparkLineIn7d(price: [
                0.9988511670388732,
                0.9988805395722454,
                0.9988938556296482,
                // ...
                0.9983923425668222
            ]),
            currentHoldings: 2.4
        )
    ]
    
    static let statistics = [
        Statistic(name: "Mark Cap", value: 12865287645258, percentage: 1.180670354),
        Statistic(name: "Total Volume", value: 5648137, percentage: -2.910657436),
        Statistic(name: "Total Volume2", value: 9568197369),
        
    ]
    #endif
}
