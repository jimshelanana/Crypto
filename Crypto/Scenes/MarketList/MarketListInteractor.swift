//
//  MarketListInteractor.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import Foundation

protocol MarketListBusinessLogic {
    func viewDidLoad()
    func didTapAlertButton()
    func didScrollToBottom()
    func selectCoin(with request: MarketListModels.SelectCoin.Request)
}

protocol MarketListDataStore {
    var selectedCoin: String? { get }
}

final class MarketListInteractor: MarketListBusinessLogic, MarketListDataStore {
    
    // MARK: - Properties
    var presenter: MarketListPresentationLogic?
    lazy var worker: MarketListWorkingLogic = MarketListWorker()
    private var marketListPage = 1
    
    // MARK: - DataStore Properties
    var selectedCoin: String?
    
    // MARK: - Business Logic
    func viewDidLoad() {
        let request = MarketListModels.CoinList.Request(page: 1)
        fetchMarketList(with: request)
    }
    
    func didTapAlertButton() {
        let request = MarketListModels.CoinList.Request(page: 1)
        fetchMarketList(with: request)
    }
    
    private func fetchMarketList(with request: MarketListModels.CoinList.Request) {
        Task {
            let response = await getMarketList(for: request)
            guard let response else { return }
            presenter?.presentData(response)
        }
    }
    
    func didScrollToBottom() {
        marketListPage += 1
        let request = MarketListModels.CoinList.Request(page: marketListPage)
        Task {
            let response = await getMarketList(for: request)
            guard let response else { return }
            presenter?.presentPrefetchedData(response)
        }
    }
    
    func selectCoin(with request: MarketListModels.SelectCoin.Request) {
        selectedCoin = request.id
    }
    
    // MARK: - Private Methods
    private func getMarketList(for request: MarketListModels.CoinList.Request) async -> MarketListModels.CoinList.Response? {
        presenter?.presentIsLoading(true)
        defer { presenter?.presentIsLoading(false) }
        
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
