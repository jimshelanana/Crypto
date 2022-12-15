//
//  MarketListView.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 17.11.22.
//

import UIKit

protocol MarketListViewLogic: UIView {
    func configure(with model: [MarketListCellModel])
    func updateModel(with prefetchedItems: [MarketListCellModel])
    func isLoadingActivateIndicator(_ isLoading: Bool)
}

final class MarketListView: UIView {
    
    // MARK: - Properties
    private weak var parentViewController: MarketListViewController?
    private var model = [MarketListCellModel]()
    private var isLoadingData = true
    
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
    
    convenience init(parentViewController: MarketListViewController) {
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
        
        tableView.register(MarketListCell.self,
                           forCellReuseIdentifier: MarketListCell.identifier)
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
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

// MARK: - MarketListViewLogic
extension MarketListView: MarketListViewLogic {
    func configure(with model: [MarketListCellModel]) {
        self.model = model
        DispatchQueue.main.async {
            self.isLoadingData = false
            self.tableView.reloadData()
        }
    }
    
    func updateModel(with prefetchedItems: [MarketListCellModel]) {
        model.append(contentsOf: prefetchedItems)
        DispatchQueue.main.async {
            self.isLoadingData = false
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
extension MarketListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MarketListCell.identifier) as? MarketListCell {
            cell.configure(with: model[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - TableView Delegate
extension MarketListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentViewController?.didSelectRow(for: model[indexPath.row].id)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 200 - scrollView.frame.size.height && isLoadingData == false {
            isLoadingData = true
            parentViewController?.didScrollToBottom()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        parentViewController?.tableViewDidStartScrolling()
    }
}
