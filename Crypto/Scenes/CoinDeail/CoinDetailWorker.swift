//
//  CoinDetailWorker.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import Foundation

protocol CoinDetailWorkingLogic {
    func fetchCoinDetail(for request: CoinDetailModels.CoinDetail.Request) async -> Result<CoinDetailModel, RequestError>
}

final class CoinDetailWorker: CoinDetailWorkingLogic {
    
    // MARK: - Private Properties
    private let cryptoService = CryptoService()
    
    // MARK: - Working Logic
    func fetchCoinDetail(for request: CoinDetailModels.CoinDetail.Request) async -> Result<CoinDetailModel, RequestError> {
        return await cryptoService.getCoinDetail(for: request.id)
    }
}
