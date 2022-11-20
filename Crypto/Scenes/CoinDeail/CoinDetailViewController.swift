//
//  CoinDetailViewController.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import UIKit

protocol CoinDetailDisplayLogic: AnyObject {
    func displayCoinDetail(_ viewModel: CoinDetailModels.CoinDetail.ViewModel)
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
        Task {
            await showCoinDetail()
        }
    }
    
    func didTapLink(by link: String) {
        requestToSelectLink(by: link)
        router?.routeToWebLink()
    }

    // MARK: - Private Method
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor(named: "PrimaryTextColor")
    }
    
    private func showCoinDetail() async {
        await interactor?.fetchCoinDetail()
    }
    
    private func requestToSelectLink(by link: String) {
        let request = CoinDetailModels.SelectLink.Request(link: link)
        
        interactor?.selectLink(with: request)
    }
}

// MARK: - Display Logic
extension CoinDetailViewController: CoinDetailDisplayLogic {
    func displayCoinDetail(_ viewModel: CoinDetailModels.CoinDetail.ViewModel) {
        DispatchQueue.main.async {
            self.contentView.configure(with: viewModel)
        }
    }
}
