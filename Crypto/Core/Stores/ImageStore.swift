//
//  ImageStore.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 18.11.22.
//

import UIKit

final class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}
