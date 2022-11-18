//
//  CoinRequestModel.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import Foundation

struct CoinRequestModel {
    let vsCurrency: String
    let order: String
    let perPage: Int
    var page: Int
    let sparkline: Bool
    let priceChangePercentage: String
}
