//
//  MarketListBusinessLogicSpy.swift
//  CryptoTests
//
//  Created by Nana Jimsheleishvili on 24.11.22.
//

import Foundation
@testable import Crypto

final class MarketListBusinessLogicSpy: MarketListBusinessLogic {
    // MARK: - Properties
    var fetchMarketListCalled = false
    var prefetchMarketListCalled = false
    var selectCoinCalled = false
    var selectedPage: Int?
    
    // MARK: - Methods
    func fetchMarketList(with request: Crypto.MarketListModels.CoinList.Request) async {
        fetchMarketListCalled = true
    }
    
    func prefetchMarketList(with request: Crypto.MarketListModels.CoinList.Request) async {
        prefetchMarketListCalled = true
        selectedPage = request.page
    }
    
    func selectCoin(with request: Crypto.MarketListModels.SelectCoin.Request) {
        selectCoinCalled = true
    }
}
