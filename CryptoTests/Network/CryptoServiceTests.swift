//
//  CryptoServiceTests.swift
//  CryptoTests
//
//  Created by Nana Jimsheleishvili on 24.11.22.
//

import XCTest
@testable import Crypto

class CryptoServiceTests: XCTestCase {
    func testMarketListServiceMock() async {
        let serviceMock = CryptoServiceMock()
        
        let model = Crypto.CoinRequestModel(vsCurrency: "",
                                            order: "",
                                            perPage: 1,
                                            page: 2,
                                            sparkline: false,
                                            priceChangePercentage: "")
        
        let failingResult = await serviceMock.getMarkets(coinRequestModel: model)
        
        switch failingResult {
        case .success(let coins):
            XCTAssertEqual(coins[0].id, "bitcoin")
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testSearchForMarketServiceMock() async {
        let serviceMock = CryptoServiceMock()
        let failingResult = await serviceMock.getSearchForMarket(for: "")
        
        switch failingResult {
        case .success(let coins):
            XCTAssertEqual(coins.coins[0].id, "bitcoin")
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testCoinDetailServiceMock() async {
        let serviceMock = CryptoServiceMock()
        let failingResult = await serviceMock.getCoinDetail(for: "")
        
        switch failingResult {
        case .success(let coin):
            XCTAssertEqual(coin.id, "bitcoin")
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testTrendingCoinsServiceMock() async {
        let serviceMock = CryptoServiceMock()
        let failingResult = await serviceMock.getTrendingCoins()
        
        switch failingResult {
        case .success(let coins):
            XCTAssertEqual(coins.coins[0].item.id, "gains-network")
        case .failure:
            XCTFail("The request should not fail")
        }
    }
}

final class CryptoServiceMock: Mockable, CryptoServiceable {
    func getMarkets(coinRequestModel: Crypto.CoinRequestModel) async -> Result<[Crypto.CoinModel], Crypto.RequestError> {
        return .success(loadJSON(filename: "market_list", type: [CoinModel].self))
    }
    
    func getSearchForMarket(for searchWord: String) async -> Result<Crypto.SearchModel, Crypto.RequestError> {
        return .success(loadJSON(filename: "search-for-coin", type: SearchModel.self))
    }
    
    func getCoinDetail(for id: String) async -> Result<Crypto.CoinDetailModel, Crypto.RequestError> {
        return .success(loadJSON(filename: "coin_detail", type: CoinDetailModel.self))
    }
    
    func getTrendingCoins() async -> Result<Crypto.TrendingCoins, Crypto.RequestError> {
        return .success(loadJSON(filename: "trending_list", type: TrendingCoins.self))
    }
}
