//
//  MarketListViewController.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

protocol MarketListDisplayLogic: AnyObject {
    
}

final class MarketListViewController: UIViewController {
    
    // MARK: - UI Outlets
    
    //
    
    // MARK: - Public Properties
    
    var interactor: MarketListBusinessLogic?
    var router: (MarketListRoutingLogic & MarketListDataPassing)?
    
    lazy var contentView: MarketListViewLogic = MarketListView()
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let interactor = MarketListInteractor()
        let presenter = MarketListPresenter()
        let router = MarketListRouter()
        
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
        configure()
    }
    
    // MARK: - Public Methods
    
    //
    
    // MARK: - Requests
    
    //
    
    // MARK: - Private Methods
    
    private func configure() {
        
    }
    
    // MARK: - UI Actions
    
    //
}

// MARK: - Display Logic

extension MarketListViewController: MarketListDisplayLogic {
    
}
