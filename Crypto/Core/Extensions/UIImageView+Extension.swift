//
//  UIImageView+Extension.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 26.11.22.
//

import UIKit

extension UIImageView {
    func loadImage(from url: String?) {
        let imageLoadService = ImageLoadService()
        imageLoadService.loadImage(with: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(_):
                self.image = UIImage(systemName: Constants.Images.photo.rawValue)
                self.tintColor = .gray
            }
        }
    }
}
