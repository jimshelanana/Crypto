//
//  CoinDetailModel.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import Foundation

struct CoinDetailModel: Codable {
    let id: String?
    let name: String?
    let image: Image?
    let links: Links?
    let marketData: MarketData?
    let marketCapRank: Int?
    let description: Description?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case links
        case marketData = "market_data"
        case marketCapRank = "market_cap_rank"
        case description
    }
    
    struct Image: Codable {
        let small: String?
    }
    
    struct Links: Codable {
        let homepage: [String]?
    }
    
    struct MarketData: Codable {
        let currentPrice: [String: Double]
        let priceChangeOneDay: Double?
        let priceChangePercentageOneDay: Double?
        
        enum CodingKeys: String, CodingKey {
            case currentPrice = "current_price"
            case priceChangeOneDay = "price_change_24h"
            case priceChangePercentageOneDay = "price_change_percentage_24h"
        }
    }
    
    struct Description: Codable {
        let en: String?
    }
}
