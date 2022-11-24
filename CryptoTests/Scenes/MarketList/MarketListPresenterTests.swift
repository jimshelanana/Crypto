//
//  MarketListPresenterTests.swift
//  CryptoTests
//
//  Created by Nana Jimsheleishvili on 24.11.22.
//

import XCTest
@testable import Crypto

final class MarketListPresenterTests: XCTestCase {
    
    // MARK: - Private Properties
    
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
    
    // MARK: - Public Methods
    
    //
}
