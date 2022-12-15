//
//  CoinDetailInteractor.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import Foundation

protocol CoinDetailBusinessLogic {
    func viewDidLoad()
    func didTapAlertButton()
    func selectLink(with request: CoinDetailModels.SelectLink.Request)
    func selectedTrendingCoin(with request: CoinDetailModels.SelectCoin.Request)
}

protocol CoinDetailDataStore {
    var selectedCoin: String? { get set }
    var selectedLink: String? { get }
}

final class CoinDetailInteractor: CoinDetailBusinessLogic, CoinDetailDataStore {
    
    // MARK: - Properties
    var presenter: CoinDetailPresentationLogic?
    lazy var worker: CoinDetailWorkingLogic = CoinDetailWorker()
    
    // MARK: - DataStore Properties
    var selectedCoin: String?
    var selectedLink: String?
    
    // MARK: - Business Logic
    func viewDidLoad() {
        Task {
            await fetchCoinDetail()
            await fetchTrendingCoins()
        }
    }
    
    func didTapAlertButton() {
        Task {
            await fetchCoinDetail()
        }
    }
    
    private func fetchCoinDetail() async {
        guard let selectedCoin else { return }
        presenter?.presentIsLoading(true)
        defer { presenter?.presentIsLoading(false) }
        
        let coinDetail = await worker.fetchCoinDetail(for: .init(id: selectedCoin))
        
        switch coinDetail {
        case .success(let data):
            let model = CoinDetailModels.CoinDetail.Response(detail: data)
            presenter?.presentCoinDetail(model)
        case .failure(let error):
            presenter?.presentServiceCallError(error: error)
        }
    }
    
    func selectLink(with request: CoinDetailModels.SelectLink.Request) {
        selectedLink = request.link
    }
    
    private func fetchTrendingCoins() async {
        let trendingCoins = await worker.fetchTrendingCoins()
        switch trendingCoins {
        case .success(let data):
            let model = CoinDetailModels.Trending.Response(coins: data)
            presenter?.presentTrendingCoins(model)
        case .failure(_):
            break
        }
    }
    
    func selectedTrendingCoin(with request: CoinDetailModels.SelectCoin.Request) {
        selectedCoin = request.id
    }
}
