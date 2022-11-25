//
//  CoinDetailView.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import UIKit

protocol CoinDetailViewLogic: UIView {
    func configure(with model: CoinDetailModels.CoinDetail.ViewModel)
    func configureTrendingList(with model: [CoinDetailModels.Trending.ViewModel])
    func isLoadingActivateIndicator(_ isLoading: Bool)
}

final class CoinDetailView: UIView {
    typealias Model = CoinDetailModels.CoinDetail.ViewModel
    
    // MARK: - Properties
    private var parentViewController: CoinDetailViewController?
    private let imageLoadService = ImageLoadService()
    private var link: String?
    private var trendingCoinList = [CoinDetailModels.Trending.ViewModel]()
    
    // MARK: - Views
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        return stackView
    }()
    
    private let wrapperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    private var coinIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return icon
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let coinPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let coinPriceChangeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let websiteStackView = UIStackView()
    
    private let websiteLabel: UILabel = {
        let label = UILabel()
        label.text = "Website:"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.isHidden = true
        return label
    }()
    
    private lazy var websiteLinkButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitleColor(.link, for: .normal)
        button.contentHorizontalAlignment = .right
        button.addAction(UIAction { [weak self] _ in
            self?.didTapWebViewButton()
        }, for: .touchUpInside)
        return button
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "INFORMATION"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.isHidden = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var collectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "TRENDING"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.isHidden = true
        return label
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let fl = UICollectionViewFlowLayout()
        fl.minimumInteritemSpacing = 16
        fl.scrollDirection = .horizontal
        fl.itemSize = CGSize(width: 152,
                             height: 92)
        fl.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return fl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
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
    
    convenience init(parentViewController: CoinDetailViewController) {
        self.init()
        self.parentViewController = parentViewController
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        setupView()
        setupCollectionView()
        addSubviews()
        addConstraints()
    }
    
    private func setupView() {
        backgroundColor = UIColor(named: Constants.Colors.accentColor.rawValue)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendingCoinListCell.self,
                                forCellWithReuseIdentifier: TrendingCoinListCell.identifier)
    }
    
    private func addSubviews() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(wrapperStackView)
        wrapperStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(coinIcon)
        titleStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(coinPriceLabel)
        mainStackView.addArrangedSubview(coinPriceChangeLabel)
        mainStackView.addArrangedSubview(websiteStackView)
        websiteStackView.addArrangedSubview(websiteLabel)
        websiteStackView.addArrangedSubview(websiteLinkButton)
        mainStackView.addArrangedSubview(descriptionTitleLabel)
        mainStackView.addArrangedSubview(descriptionLabel)
        mainStackView.addArrangedSubview(collectionTitleLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(activityIndicator)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            collectionView.heightAnchor.constraint(equalToConstant: 92)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // MARK: - Private Methods
    private func didTapWebViewButton() {
        guard let link else { return }
        parentViewController?.didTapLink(by: link)
    }
    
    private func setupCoinPriceChangeLabel(with priceChangeOneDay: String,
                                           priceChangePercentageOneDay: String,
                                           isPriceChangePositive: Bool) {
        let attributedStr = NSMutableAttributedString(string: priceChangeOneDay + "  ")
        attributedStr.append(NSAttributedString(
            string: priceChangePercentageOneDay,
            attributes: [.foregroundColor: isPriceChangePositive
                         ? UIColor.green
                         : UIColor.red])
        )
        coinPriceChangeLabel.attributedText = attributedStr
    }
}

// MARK: - CoinDetailViewLogic
extension CoinDetailView: CoinDetailViewLogic {
    func configure(with model: Model) {
        nameLabel.text = model.name.uppercased()
        coinPriceLabel.text = model.currentPriceInUSD
        link = model.link
        descriptionLabel.text = model.description
        coinIcon.loadImage(from: model.image)
        websiteLinkButton.setTitle(model.link, for: .normal)
        setupCoinPriceChangeLabel(with: model.priceChangeOneDay,
                                  priceChangePercentageOneDay: model.priceChangePercentageOneDay,
                                  isPriceChangePositive: model.isPriceChangePositive)
        websiteLabel.isHidden = model.link.isEmpty
        descriptionTitleLabel.isHidden = model.description.isEmpty
        
    }
    
    func configureTrendingList(with model: [CoinDetailModels.Trending.ViewModel]) {
        trendingCoinList = model
        DispatchQueue.main.async {
            self.collectionTitleLabel.isHidden = model.isEmpty
            self.collectionView.reloadData()
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

// MARK: UICollectionViewDataSource
extension CoinDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trendingCoinList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCoinListCell.identifier, for: indexPath) as? TrendingCoinListCell {
            cell.configure(with: trendingCoinList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: UICollectionViewDelegate
extension CoinDetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let coin = trendingCoinList[indexPath.row].id else{ return }
        parentViewController?.didSelectTrendingCoin(by: coin)
    }
}
