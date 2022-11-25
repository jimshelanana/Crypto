//
//  MarketListModels.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

enum MarketListModels {
    
    // MARK: - CoinList
    enum CoinList {
        struct Request {
            let page: Int
        }
        
        struct Response {
            let list: [CoinModel]
        }
        
        struct ViewModel {
            let marketListCellModel: [MarketListCellModel]
        }
    }
    
    // MARK: - SelectCoin
    enum SelectCoin {
        struct Request {
            let id: String
        }
    }
}
