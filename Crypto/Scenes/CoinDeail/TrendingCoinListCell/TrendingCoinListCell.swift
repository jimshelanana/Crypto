//
//  TrendingCoinListCell.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 23.11.22.
//

import UIKit

final class TrendingCoinListCell: UICollectionViewCell {
    // MARK: - Properties
    private let imageLoadService = ImageLoadService()
    
    // MARK: - Views
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        stackView.spacing = 10
        return stackView
    }()
    
    private let coinRankingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let rankingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        iconImageView.image = nil
    }

    // MARK: - Setup
    private func setup() {
        setupUI()
        addSubviews()
        addConstraints()
    }
    
    private func setupUI() {
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray.cgColor
        contentView.layer.masksToBounds = true
    }
    
    private func addSubviews() {
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(coinRankingStackView)
        coinRankingStackView.addArrangedSubview(iconImageView)
        coinRankingStackView.addArrangedSubview(rankingLabel)
        mainStackView.addArrangedSubview(nameLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    // MARK: - Configure
    func configure(with model: CoinDetailModels.Trending.ViewModel) {
        nameLabel.text = model.name
        rankingLabel.text = model.marketRank
        loadImage(with: model.image)
    }
    
    // MARK: - Private Methods
    private func loadImage(with url: String?) {
        imageLoadService.loadImage(with: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.iconImageView.image = image
                }
            case .failure(_):
                self.iconImageView.image = UIImage(systemName: "photo")
                self.iconImageView.tintColor = .gray
            }
        }
    }
}
