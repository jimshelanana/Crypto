//
//  MarketListRouter.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

protocol MarketListRoutingLogic {
    func routeToCoinDetail()
}

protocol MarketListDataPassing {
    var dataStore: MarketListDataStore? { get }
}

final class MarketListRouter: MarketListRoutingLogic, MarketListDataPassing {
    
    // MARK: - Public Properties
    weak var viewController: MarketListViewController?
    var dataStore: MarketListDataStore?
    
    // MARK: - RoutingLogic
    func routeToCoinDetail() {
        guard let coinDetailVC = getCoinDetailVC() else { return }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            guard let selfVC = viewController else { return }
            let splitVC = UISplitViewController(style: .doubleColumn)
            splitVC.viewControllers = [
                selfVC,
                coinDetailVC
            ]
            viewController?.view.window?.rootViewController = splitVC
        } else {
            viewController?.navigationController?.pushViewController(coinDetailVC, animated: true)
        }
    }
    
    // MARK: - Private Methods
    private func getCoinDetailVC() -> UIViewController? {
        let coinDetailVC = CoinDetailViewController()
        guard var coinDetailDataStore = coinDetailVC.router?.dataStore else { return nil }
        coinDetailDataStore.selectedCoin = dataStore?.selectedCoin
        return coinDetailVC
    }
}
