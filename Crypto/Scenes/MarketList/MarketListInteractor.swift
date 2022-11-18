//
//  MarketListInteractor.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import Foundation

protocol MarketListBusinessLogic {
    func fetchMarketList(with request: MarketListModels.FetchCoins.Request) async
}

protocol MarketListDataStore {
    
}

final class MarketListInteractor: MarketListBusinessLogic, MarketListDataStore {
    
    // MARK: - Properties
    var presenter: MarketListPresentationLogic?
    lazy var worker: MarketListWorkingLogic = MarketListWorker()
    
    // MARK: - Business Logic
    func fetchMarketList(with request: MarketListModels.FetchCoins.Request) async {
        let marketList = await worker.fetchMarketList(with: request)
        switch marketList {
        case .success(let data):
            let model = MarketListModels.FetchCoins.Response(list: data)
            presenter?.presentData(model)
        case .failure(_):
            break
        }
    }
}
