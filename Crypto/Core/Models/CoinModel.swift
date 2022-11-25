//
//  CoinModel.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import Foundation

struct CoinModel: Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let image: String?
    let currentPrice: Double?
    let priceChangePercentageOneDay: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case priceChangePercentageOneDay = "price_change_percentage_24h"
    }
}
