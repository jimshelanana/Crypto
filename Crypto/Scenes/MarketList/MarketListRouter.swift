//
//  MarketListRouter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

protocol MarketListRoutingLogic {
    
}

protocol MarketListDataPassing {
    var dataStore: MarketListDataStore? { get }
}

final class MarketListRouter: MarketListRoutingLogic, MarketListDataPassing {
    
    // MARK: - Public Properties
    
    weak var viewController: MarketListViewController?
    var dataStore: MarketListDataStore?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Routing Logic
    
    //
    
    // MARK: - Navigation
    
    //
    
    // MARK: - Passing data
    
    //
}
