//
//  SearchMarketListModels.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import UIKit

enum SearchMarketListModels {
    enum CoinList {
        struct Request {
            let searchWord: String
        }
        
        struct Response {
            let list: SearchModel
        }
        
        struct ViewModel {
            let searchListCellModel: [MarketListCellModel]
        }
    }
}
