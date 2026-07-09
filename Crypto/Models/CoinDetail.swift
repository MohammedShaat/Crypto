//
//  CoinDetail.swift
//  Crypto
//
//  Created by Mohammed on 7/7/26.
//

import Foundation

struct CoinDetail: Codable {
    let id: String
    let symbol: String
    let name: String
    let webSlug: String
    let blockTimeInMinutes: Int
    let hashingAlgorithm: String?
    let categories: [String]
    let hasSupplyBreakdown: Bool
    let description: Description
    let links: Links
    let lastUpdated: String
        
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case webSlug = "web_slug"
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case categories
        case hasSupplyBreakdown = "has_supply_breakdown"
        case description
        case links
        case lastUpdated = "last_updated"
    }
}

struct Description: Codable {
    let en: String
}

struct Links: Codable {
    let homepage: [String]
    let twitterScreenName: String?
    let facebookUsername: String?
    let telegramChannelIdentifier: String?
    let subredditUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case twitterScreenName = "twitter_screen_name"
        case facebookUsername = "facebook_username"
        case telegramChannelIdentifier = "telegram_channel_identifier"
        case subredditUrl = "subreddit_url"
    }
}

