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
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "MarketList", bundle: bundle)
        
        let viewController = storyboard.instantiateViewController(
            identifier: "MarketListViewController") as? MarketListViewController
        let interactor = MarketListBusinessLogicSpy()
        
        viewController?.interactor = interactor
        
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
    
    // MARK: - Public Methods
    
    //
}
