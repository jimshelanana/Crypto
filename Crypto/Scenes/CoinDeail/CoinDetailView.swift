//
//  CoinDetailView.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 20.11.22.
//

import UIKit

protocol CoinDetailViewLogic: UIView {
    func configure(with model: CoinDetailModels.CoinDetail.ViewModel)
}

final class CoinDetailView: UIView {
    typealias Model = CoinDetailModels.CoinDetail.ViewModel
    
    // MARK: - Properties
    private var parentViewController: CoinDetailViewController?
    private let imageLoadService = ImageLoadService()
    private var link: String?
    
    // MARK: - Views
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        return stackView
    }()

    private let coinButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.configuration?.imagePadding = 8
        button.tintColor = UIColor(named: "PrimaryTextColor")
        return button
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
    
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Website"
        return label
    }()
    
    private lazy var websiteLinkButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitleColor(.link, for: .normal)
        button.addAction(UIAction { [weak self] _ in
            self?.didTapWebViewButton()
        }, for: .touchUpInside)
        return button
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
        setupUI()
        addSubviews()
        addConstraints()
    }
    
    private func setupUI() {
        backgroundColor = UIColor(named: "AccentColor")
    }
    
    private func addSubviews() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(coinButton)
        mainStackView.addArrangedSubview(coinPriceLabel)
        mainStackView.addArrangedSubview(coinPriceChangeLabel)
        mainStackView.addArrangedSubview(websiteStackView)
        websiteStackView.addArrangedSubview(websiteLabel)
        websiteStackView.addArrangedSubview(websiteLinkButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
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
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            mainStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32)
        ])
    }
    
    // MARK: - Private Methods
    private func loadImage(with url: String?) {
        imageLoadService.loadImage(with: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.coinButton.setImage(image, for: .normal)
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func didTapWebViewButton() {
        guard let link else { return }
        parentViewController?.didTapLink(by: link)
    }
    
    private func setupCoinPriceChangeLabel(with priceChangeOneDay: String, priceChangePercentageOneDay: String, isPriceChangePositive: Bool) {
        let attributedStr = NSMutableAttributedString(string: priceChangeOneDay + "  ")
        attributedStr.append(NSAttributedString(string: priceChangePercentageOneDay,
                                                attributes: [.foregroundColor: isPriceChangePositive ? UIColor.green : UIColor.red]))
        coinPriceChangeLabel.attributedText = attributedStr
        
    }
}

// MARK: - CoinDetailViewLogic
extension CoinDetailView: CoinDetailViewLogic {
    func configure(with model: Model) {
        coinButton.setTitle(model.name, for: .normal)
        coinPriceLabel.text = model.currentPriceInUSD
        link = model.link
        loadImage(with: model.image)
        websiteLinkButton.setTitle(model.link, for: .normal)
        setupCoinPriceChangeLabel(with: model.priceChangeOneDay,
                                  priceChangePercentageOneDay: model.priceChangePercentageOneDay,
                                  isPriceChangePositive: model.isPriceChangePositive)
    }
}
