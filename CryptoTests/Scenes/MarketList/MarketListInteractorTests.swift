//
//  MarketListInteractorTests.swift
//  CryptoTests
//
//  Created by Nana Jimsheleishvili on 24.11.22.
//

import XCTest
@testable import Crypto

final class MarketListInteractorTests: XCTestCase {
    
    // MARK: - Private Properties
    
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
    
    // MARK: - Public Methods
    
    //
}
