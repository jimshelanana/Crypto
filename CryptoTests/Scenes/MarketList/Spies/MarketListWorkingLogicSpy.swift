//
//  MarketListWorkingLogicSpy.swift
//  CryptoTests
//
//  Created by Nana Jimsheleishvili on 24.11.22.
//

import Foundation
@testable import Crypto

final class MarketListWorkingLogicSpy: MarketListWorkingLogic {
    // MARK: - Properties
    var fetchMarketListCalled = false
    var requestPage: Int?

    // MARK: - Methods
    func fetchMarketList(with request: Crypto.MarketListModels.CoinList.Request) async -> Result<[Crypto.CoinModel], Crypto.RequestError> {
        fetchMarketListCalled = true
        requestPage = request.page
        return .success([])
    }
}
