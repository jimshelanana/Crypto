//
//  SearchMarketListRouter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import UIKit

protocol SearchMarketListRoutingLogic {
    
}

protocol SearchMarketListDataPassing {
    var dataStore: SearchMarketListDataStore? { get }
}

final class SearchMarketListRouter: SearchMarketListRoutingLogic, SearchMarketListDataPassing {
    
    // MARK: - Public Properties
    
    weak var viewController: SearchMarketListViewController?
    var dataStore: SearchMarketListDataStore?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Routing Logic
    
    //
    
    // MARK: - Navigation
    
    //
    
    // MARK: - Passing data
    
    //
}
