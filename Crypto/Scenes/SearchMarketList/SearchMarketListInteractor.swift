//
//  SearchMarketListInteractor.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import Foundation

protocol SearchMarketListBusinessLogic {
    func fetchSearchMarketList(with request: SearchMarketListModels.CoinList.Request) async
    func selectCoin(with request: SearchMarketListModels.SelectCoin.Request)
}

protocol SearchMarketListDataStore {
    var selectedCoin: String? { get }
}

final class SearchMarketListInteractor: SearchMarketListBusinessLogic, SearchMarketListDataStore {
    
    // MARK: - Properties
    var presenter: SearchMarketListPresentationLogic?
    lazy var worker: SearchMarketListWorkingLogic = SearchMarketListWorker()
    
    // MARK: - DataStore Properties
    var selectedCoin: String?
    
    // MARK: - Business Logic
    func fetchSearchMarketList(with request: SearchMarketListModels.CoinList.Request) async {
        presenter?.presentIsLoading(true)
        defer { presenter?.presentIsLoading(false) }
        
        let searchList = await worker.fetchSearchMarketList(with: request)
        switch searchList {
        case .success(let data):
            let model = SearchMarketListModels.CoinList.Response(list: data)
            presenter?.presentSearchData(model)
        case .failure(_):
            break
        }
    }
    
    func selectCoin(with request: SearchMarketListModels.SelectCoin.Request) {
        selectedCoin = request.id
    }
}
