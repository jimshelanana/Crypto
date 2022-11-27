//
//  MarketListViewControllerTests.swift
//  CryptoTests
//
//  Created by Nana Jimsheleishvili on 24.11.22.
//

import XCTest
@testable import Crypto

final class MarketListViewControllerTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: MarketListViewController!
    private var interactor: MarketListBusinessLogicSpy!
    private var window: UIWindow!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let mainWindow = UIWindow()

        let viewController = MarketListViewController()
        let interactor = MarketListBusinessLogicSpy()
        
        viewController.interactor = interactor
        
        sut = viewController
        window = mainWindow
        self.interactor = interactor
        
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        window = nil
        
        super.tearDown()
    }
    
    // MARK: - Methods
    func testViewDidLoad() {
        // when
        sut.viewDidLoad()
        
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertTrue(self.interactor.fetchMarketListCalled)
        }
    }
    
    func testStartPrefetching() async {
        // given
        let page = 3
        XCTAssertFalse(interactor.prefetchMarketListCalled)
        
        // when
        await sut.startPrefetching(for: page)
        
        // then
        XCTAssertTrue(interactor.prefetchMarketListCalled)
        XCTAssertEqual(interactor.selectedPage, page)
    }
}
