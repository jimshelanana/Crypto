//
//  CoinDetailModels.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import UIKit

enum CoinDetailModels {
    enum CoinDetail {
        struct Request {
            let id: String
        }
        
        struct Response {
            let detail: CoinDetailModel
        }
        
        struct ViewModel {
            let id: String
            let name: String
            let image: String
            let link: String
            let currentPriceInUSD: String
            let marketCapRank: String
            let priceChangeOneDay: String
            let priceChangePercentageOneDay: String
            let isPriceChangePositive: Bool
            let description: String
        }
    }
    
    enum Trending {
        struct Request {
        }
        
        struct Response {
            let coins: TrendingCoins
        }
        
        struct ViewModel {
            let id: String?
            let name: String?
            let image: String?
            let marketRank: String?
        }
    }
    
    enum SelectLink {
      struct Request {
        let link: String
      }
    }
}
