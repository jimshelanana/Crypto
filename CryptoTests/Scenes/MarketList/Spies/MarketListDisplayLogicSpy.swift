//
//  MarketListDisplayLogicSpy.swift
//  CryptoTests
//
//  Created by Nana Jimsheleishvili on 24.11.22.
//

import Foundation
@testable import Crypto

final class MarketListDisplayLogicSpy: MarketListDisplayLogic {
    // MARK: - Properties
    var displayMarketListCalled = false
    var displayPrefetchedMarketListCalled = false
    var displayServiceCallErrorCalled = false
    var displayIsLoadingCalled = false
    var marketListModel: [MarketListCellModel] = []
    var isLoading: Bool?
    
    // MARK: - Methods
    func displayMarketList(_ viewModel: Crypto.MarketListModels.CoinList.ViewModel) {
        displayMarketListCalled = true
        marketListModel = viewModel.marketListCellModel
    }
    
    func displayPrefetchedMarketList(_ viewModel: Crypto.MarketListModels.CoinList.ViewModel) {
        displayPrefetchedMarketListCalled = true
        marketListModel = viewModel.marketListCellModel
    }
    
    func displayServiceCallError(_ error: String) {
        displayServiceCallErrorCalled = true
    }
    
    func displayIsLoading(_ isLoading: Bool) {
        displayIsLoadingCalled = true
        self.isLoading = isLoading
    }
}
