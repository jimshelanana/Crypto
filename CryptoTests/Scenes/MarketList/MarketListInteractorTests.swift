//
//  MarketListInteractorTests.swift
//  CryptoTests
//
//  Created by Nana Jimsheleishvili on 24.11.22.
//

import XCTest
@testable import Crypto

final class MarketListInteractorTests: XCTestCase {
    
    // MARK: - Properties
    private var sut: MarketListInteractor!
    private var worker: MarketListWorkingLogicSpy!
    private var presenter: MarketListPresentationLogicSpy!
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        
        let interactor = MarketListInteractor()
        let worker = MarketListWorkingLogicSpy()
        let presenter = MarketListPresentationLogicSpy()
        
        interactor.worker = worker
        interactor.presenter = presenter
        
        sut = interactor
        self.worker = worker
        self.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        worker = nil
        presenter = nil
        
        super.tearDown()
    }
    
    // MARK: - Methods
    func testFetchMarketList() async {
        // given
        let page = 1
        let coinListRequest = MarketListModels.CoinList.Request(page: page)
        XCTAssertFalse(worker.fetchMarketListCalled)
        
        // when
        await sut.fetchMarketList(with: coinListRequest)
        
        // then
        XCTAssertTrue(worker.fetchMarketListCalled)
        XCTAssertTrue(presenter.presentDataCalled)
        XCTAssertEqual(worker.requestPage, page)
    }
    
    func testPrefetchMarketList() async {
        // given
        let page = 2
        let coinListRequest = MarketListModels.CoinList.Request(page: page)
        XCTAssertFalse(worker.fetchMarketListCalled)
        
        // when
        await sut.prefetchMarketList(with: coinListRequest)
        
        // then
        XCTAssertTrue(worker.fetchMarketListCalled)
        XCTAssertTrue(presenter.presentPrefetchedDataCalled)
        XCTAssertEqual(worker.requestPage, page)
    }
}
