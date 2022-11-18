//
//  CryptoService.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 16.11.22.
//

import Foundation

import Foundation

protocol CryptoServiceable {
    func getMarkets(coinRequestModel: CoinRequestModel) async -> Result<[CoinModel], RequestError>
}

struct CryptoService: HTTPClient, CryptoServiceable {
    func getMarkets(coinRequestModel: CoinRequestModel) async -> Result<[CoinModel], RequestError> {
        return await sendRequest(endpoint: CryptoEndpoint.markets(coinRequestModel),
                                 responseModel: [CoinModel].self)
    }
}
