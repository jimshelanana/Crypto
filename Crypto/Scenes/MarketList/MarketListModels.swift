//
//  MarketListModels.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

enum MarketListModels {
    enum FetchCoins {
        struct Request {
            let page: Int
        }
        
        struct Response {
            let list: [CoinModel]
        }
        
        struct ViewModel {
            let marketListCellModel: [MarketListCellModel]
        }
        
        struct MarketListCellModel {
            let id: String
            let symbol: String
            let name: String
            let image: String
            let currentPrice: String
            let priceChangePercentageOneDay: String
            let isPriceChangePositive: Bool
        }
    }
}
