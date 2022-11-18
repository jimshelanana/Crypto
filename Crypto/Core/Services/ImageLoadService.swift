//
//  ImageLoadService.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 18.11.22.
//

import UIKit

final class ImageLoadService {
    func loadImage(with url: String?, completion: @escaping ((Result<UIImage, RequestError>) -> Void)) {
        DispatchQueue.global().async {
            guard let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            
            let urlToString = url.absoluteString as NSString
            if let cachedImage = ImageStore.imageCache.object(forKey: urlToString) {
                completion(.success(cachedImage))
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageStore.imageCache.setObject(image, forKey: urlToString)
                    completion(.success(image))
                }
            } else {
                completion(.failure(.imageDownloadFailed))
            }
        }
    }
}
