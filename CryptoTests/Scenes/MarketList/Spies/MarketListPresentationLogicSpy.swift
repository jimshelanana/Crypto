//
//  MarketListPresentationLogicSpy.swift
//  CryptoTests
//
//  Created by Nana Jimsheleishvili on 24.11.22.
//

import Foundation
@testable import Crypto

final class MarketListPresentationLogicSpy: MarketListPresentationLogic {
    // MARK: - Properties
    var presentDataCalled = false
    var presentPrefetchedDataCalled = false
    var presentServiceCallErrorCalled = false
    var presentIsLoadingCalled = false
    
    // MARK: - Methods
    func presentData(_ response: Crypto.MarketListModels.CoinList.Response) {
        presentDataCalled = true
    }
    
    func presentPrefetchedData(_ response: Crypto.MarketListModels.CoinList.Response) {
        presentPrefetchedDataCalled = true
    }
    
    func presentServiceCallError(error: Crypto.RequestError) {
        presentServiceCallErrorCalled = true
    }
    
    func presentIsLoading(_ isLoading: Bool) {
        presentIsLoadingCalled = true
    }
}
