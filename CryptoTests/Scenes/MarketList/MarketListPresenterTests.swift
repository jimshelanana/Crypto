//
//  MarketListPresenterTests.swift
//  CryptoTests
//
//  Created by Nana Jimsheleishvili on 24.11.22.
//

import XCTest
@testable import Crypto

final class MarketListPresenterTests: XCTestCase {
    
    // MARK: - Properties
    private var sut: MarketListPresenter!
    private var viewController: MarketListDisplayLogicSpy!
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        
        let presenter = MarketListPresenter()
        let viewController = MarketListDisplayLogicSpy()
        
        presenter.viewController = viewController
        
        sut = presenter
        self.viewController = viewController
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    // MARK: - Methods
    func testPresentData() {
        // given
        let list = [
            CoinModel(id: "bitcoin",
                      symbol: nil,
                      name: nil,
                      image: nil,
                      currentPrice: nil,
                      priceChangePercentageOneDay: nil)
        ]
        let coinListModel = MarketListModels.CoinList.Response(list: list)
        XCTAssertFalse(viewController.displayMarketListCalled)
        
        // when
        sut.presentData(coinListModel)
        
        // then
        XCTAssertTrue(viewController.displayMarketListCalled)
        
        XCTAssertEqual(viewController.marketListModel.first?.id, "bitcoin")
        XCTAssertEqual(viewController.marketListModel.first?.name, "")
    }
    
    func testPresentPrefetchedData() {
        // given
        let list = [
            CoinModel(id: nil,
                      symbol: "btc",
                      name: nil,
                      image: nil,
                      currentPrice: nil,
                      priceChangePercentageOneDay: nil)
        ]
        let coinListModel = MarketListModels.CoinList.Response(list: list)
        XCTAssertFalse(viewController.displayPrefetchedMarketListCalled)
        
        // when
        sut.presentPrefetchedData(coinListModel)
        
        // then
        XCTAssertTrue(viewController.displayPrefetchedMarketListCalled)
        
        XCTAssertEqual(viewController.marketListModel.first?.id, "")
        XCTAssertEqual(viewController.marketListModel.first?.symbol, "BTC")
    }
    
    func testPresentServiceCallError() {
        // given
        XCTAssertFalse(viewController.displayServiceCallErrorCalled)
        
        // when
        sut.presentServiceCallError(error: .noResponse)
        
        // then
        XCTAssertTrue(viewController.displayServiceCallErrorCalled)
    }
    
    func testPresentIsLoading() {
        // given
        XCTAssertNil(viewController.isLoading)
        XCTAssertFalse(viewController.displayIsLoadingCalled)
        
        // when
        sut.presentIsLoading(true)
        
        // then
        XCTAssertTrue(viewController.displayIsLoadingCalled)
        
        XCTAssertEqual(viewController.isLoading, true)
    }
}
