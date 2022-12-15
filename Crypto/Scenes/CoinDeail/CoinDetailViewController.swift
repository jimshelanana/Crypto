//
//  CoinDetailViewController.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import UIKit

protocol CoinDetailDisplayLogic: AnyObject {
    func displayCoinDetail(_ viewModel: CoinDetailModels.CoinDetail.ViewModel)
    func displayTrendingCoins(_ viewModel: [CoinDetailModels.Trending.ViewModel])
    func displayServiceCallError(_ error: String)
    func displayIsLoading(_ isLoading: Bool) 
}

final class CoinDetailViewController: UIViewController {
    
    // MARK: - Properties
    var interactor: CoinDetailBusinessLogic?
    var router: (CoinDetailRoutingLogic & CoinDetailDataPassing)?
    
    private lazy var contentView: CoinDetailViewLogic = CoinDetailView(parentViewController: self)
    
    // MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let interactor = CoinDetailInteractor()
        let presenter = CoinDetailPresenter()
        let router = CoinDetailRouter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
        
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        interactor?.viewDidLoad()
    }
    
    func didTapLink(by link: String) {
        requestToSelectLink(by: link)
        router?.routeToWebLink()
    }
    
    func didSelectTrendingCoin(by id: String) {
        requestToSelectTrendingCoin(by: id)
        router?.routeToCoinDetailPage()
    }
    
    // MARK: - Private Method
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor(named: "PrimaryTextColor")
    }

    private func requestToSelectLink(by link: String) {
        let request = CoinDetailModels.SelectLink.Request(link: link)
        
        interactor?.selectLink(with: request)
    }
    
    private func requestToSelectTrendingCoin(by id: String) {
        let request = CoinDetailModels.SelectCoin.Request(id: id)
        
        interactor?.selectedTrendingCoin(with: request)
    }
}

// MARK: - Display Logic
extension CoinDetailViewController: CoinDetailDisplayLogic {
    func displayCoinDetail(_ viewModel: CoinDetailModels.CoinDetail.ViewModel) {
        DispatchQueue.main.async {
            self.contentView.configure(with: viewModel)
        }
    }
    
    func displayTrendingCoins(_ viewModel: [CoinDetailModels.Trending.ViewModel]) {
        contentView.configureTrendingList(with: viewModel)
    }
    
    func displayServiceCallError(_ error: String) {
        let alert = UIAlertController(title: error, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
            self?.interactor?.didTapAlertButton()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func displayIsLoading(_ isLoading: Bool) {
        contentView.isLoadingActivateIndicator(isLoading)
    }
}
