//
//  CryptoService.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 16.11.22.
//

import Foundation

protocol CryptoServiceable {
    func getMarkets(coinRequestModel: CoinRequestModel) async -> Result<[CoinModel], RequestError>
    func getSearchForMarket(for searchWord: String) async -> Result<SearchModel, RequestError>
    func getCoinDetail(for id: String) async -> Result<CoinDetailModel, RequestError>
    func getTrendingCoins() async -> Result<TrendingCoins, RequestError>
}

// MARK: - CryptoService
struct CryptoService: HTTPClient, CryptoServiceable {
    func getMarkets(coinRequestModel: CoinRequestModel) async -> Result<[CoinModel], RequestError> {
        await sendRequest(endpoint: CryptoEndpoint.markets(coinRequestModel),
                          responseModel: [CoinModel].self)
    }
    
    func getSearchForMarket(for searchWord: String) async -> Result<SearchModel, RequestError> {
        await sendRequest(endpoint: CryptoEndpoint.search(searchWord),
                          responseModel: SearchModel.self)
    }
    
    func getCoinDetail(for id: String) async -> Result<CoinDetailModel, RequestError> {
        await sendRequest(endpoint: CryptoEndpoint.detail(id),
                          responseModel: CoinDetailModel.self)
    }
    
    func getTrendingCoins() async -> Result<TrendingCoins, RequestError> {
        await sendRequest(endpoint: CryptoEndpoint.trending,
                          responseModel: TrendingCoins.self)
    }
}
