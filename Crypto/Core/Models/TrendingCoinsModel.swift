//
//  TrendingCoinsModel.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 23.11.22.
//

import Foundation

struct TrendingCoins: Codable {
    let coins: [TrendingItems]
}

struct TrendingItems: Codable {
    let item: TrendingCoinsModel
}

struct TrendingCoinsModel: Codable {
    let id: String?
    let name: String?
    let image: String?
    let marketRank: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "small"
        case marketRank = "market_cap_rank"
    }
}
