//
//  SearchMarketListWorker.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import Foundation

protocol SearchMarketListWorkingLogic {
    func fetchSearchMarketList(with request: SearchMarketListModels.CoinList.Request) async -> Result<SearchModel, RequestError>
}

final class SearchMarketListWorker: SearchMarketListWorkingLogic {
    
    // MARK: - Private Properties
    private let cryptoService = CryptoService()
    
    // MARK: - Working Logic
    func fetchSearchMarketList(with request: SearchMarketListModels.CoinList.Request) async -> Result<SearchModel, RequestError> {
        return await cryptoService.getSearchForMarket(for: request.searchWord)
    }
}
