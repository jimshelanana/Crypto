//
//  MarketListCellModel.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import Foundation

struct MarketListCellModel {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: String?
    let priceChangePercentageOneDay: String?
    let isPriceChangePositive: Bool?
    
    init(id: String,
         symbol: String,
         name: String,
         image: String,
         currentPrice: String? = nil,
         priceChangePercentageOneDay: String? = nil,
         isPriceChangePositive: Bool? = nil) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.priceChangePercentageOneDay = priceChangePercentageOneDay
        self.isPriceChangePositive = isPriceChangePositive
    }
}
