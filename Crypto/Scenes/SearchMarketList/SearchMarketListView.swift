//
//  SearchMarketListView.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 19.11.22.
//

import UIKit

protocol SearchMarketListViewLogic: UIView {
    func configure(with model: [MarketListCellModel])
    func isLoadingActivateIndicator(_ isLoading: Bool)
}

final class SearchMarketListView: UIView {
    
    // MARK: - Properties
    private var parentViewController: SearchMarketListViewController?
    private var model = [MarketListCellModel]()
    
    // MARK: - Views
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = true
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: - Init
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(parentViewController: SearchMarketListViewController) {
        self.init()
        self.parentViewController = parentViewController
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setup() {
        setupView()
        addSubviews()
        addConstraints()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchMarketListCell.self,
                           forCellReuseIdentifier: Constants.CellName.searchCoin.rawValue)
    }
    
    private func setupView() {
        backgroundColor = UIColor(named: Constants.Colors.accentColor.rawValue)
    }
    
    private func addSubviews() {
        self.addSubview(tableView)
        tableView.addSubview(activityIndicator)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
    }
}

// MARK: - MarketListViewLogic
extension SearchMarketListView: SearchMarketListViewLogic {
    func configure(with model: [MarketListCellModel]) {
        self.model = model
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func isLoadingActivateIndicator(_ isLoading: Bool) {
        DispatchQueue.main.async {
            isLoading
            ? self.activityIndicator.startAnimating()
            : self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - TableView DataSource
extension SearchMarketListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellName.searchCoin.rawValue) as? SearchMarketListCell {
            cell.configure(with: model[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - TableView Delegate
extension SearchMarketListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentViewController?.didSelectRow(for: model[indexPath.row].id)
    }
}
