//
//  MarketListInteractor.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import Foundation

protocol MarketListBusinessLogic {
    func fetchMarketList(with request: MarketListModels.CoinList.Request) async
    func prefetchMarketList(with request: MarketListModels.CoinList.Request) async
    func selectCoin(with request: MarketListModels.SelectCoin.Request)
}

protocol MarketListDataStore {
    var selectedCoin: String? { get }
}

final class MarketListInteractor: MarketListBusinessLogic, MarketListDataStore {
    
    // MARK: - Properties
    var presenter: MarketListPresentationLogic?
    lazy var worker: MarketListWorkingLogic = MarketListWorker()
    var selectedCoin: String?
    
    // MARK: - Business Logic
    func fetchMarketList(with request: MarketListModels.CoinList.Request) async {
        guard let response = await getMarketList(for: request) else { return }
        presenter?.presentData(response)
    }
    
    func prefetchMarketList(with request: MarketListModels.CoinList.Request) async {
        guard let response = await getMarketList(for: request) else { return }
        presenter?.presentPrefetchedData(response)
    }
    
    func selectCoin(with request: MarketListModels.SelectCoin.Request) {
        selectedCoin = request.id
    }
    
    // MARK: - Private Methods
    private func getMarketList(for request: MarketListModels.CoinList.Request) async -> MarketListModels.CoinList.Response? {
        let marketList = await worker.fetchMarketList(with: request)
        switch marketList {
        case .success(let data):
            return MarketListModels.CoinList.Response(list: data)
        case .failure(let error):
            presenter?.presentServiceCallError(error: error)
            return nil
        }
    }
}
