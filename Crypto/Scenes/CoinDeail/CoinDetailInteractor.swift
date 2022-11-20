//
//  CoinDetailInteractor.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import Foundation

protocol CoinDetailBusinessLogic {
    func fetchCoinDetail() async
    func selectLink(with request: CoinDetailModels.SelectLink.Request)
}

protocol CoinDetailDataStore {
    var selectedCoin: String? { get set }
    var selectedLink: String? { get }
}

final class CoinDetailInteractor: CoinDetailBusinessLogic, CoinDetailDataStore {
    
    // MARK: - Public Properties
    
    var presenter: CoinDetailPresentationLogic?
    lazy var worker: CoinDetailWorkingLogic = CoinDetailWorker()
    var selectedCoin: String?
    var selectedLink: String?
    
    // MARK: - Business Logic
    func fetchCoinDetail() async {
        guard let selectedCoin else { return }
        let coinDetail = await worker.fetchCoinDetail(for: .init(id: selectedCoin))
        switch coinDetail {
        case .success(let data):
            let model = CoinDetailModels.CoinDetail.Response(detail: data)
            presenter?.presentCoinDetail(model)
        case .failure(_):
            //TODO: Errorhandling
            break
        }
    }
    
    func selectLink(with request: CoinDetailModels.SelectLink.Request) {
        selectedLink = request.link
    }
}