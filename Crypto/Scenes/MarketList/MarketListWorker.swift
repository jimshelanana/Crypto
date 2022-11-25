//
//  MarketListWorker.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import Foundation

protocol MarketListWorkingLogic {
    func fetchMarketList(with request: MarketListModels.CoinList.Request) async -> Result<[CoinModel], RequestError>
}

final class MarketListWorker: MarketListWorkingLogic {
    
    // MARK: - Private Properties
    private let cryptoService = CryptoService()
    private var coinRequestModel = CoinRequestModel(
        vsCurrency: "usd",
        order: "market_cap_desc",
        perPage: 20,
        page: 1,
        sparkline: false,
        priceChangePercentage: "24h"
    )
    
    // MARK: - Working Logic
    func fetchMarketList(with request: MarketListModels.CoinList.Request) async -> Result<[CoinModel], RequestError> {
        coinRequestModel.page = request.page
        return await cryptoService.getMarkets(coinRequestModel: coinRequestModel)
    }
}
