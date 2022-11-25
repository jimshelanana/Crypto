//
//  SearchMarketListModels.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import UIKit

enum SearchMarketListModels {
    
    // MARK: - CoinList
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
    
    // MARK: - SelectCoin
    enum SelectCoin {
        struct Request {
            let id: String
        }
    }
}
