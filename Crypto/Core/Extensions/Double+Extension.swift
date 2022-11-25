//
//  Double+Extension.swift
//  Crypto
//
//  Created by Nana Jimsheleishvili on 18.11.22.
//

import Foundation

extension Double {
    var percentString: String {
        return String(format: "%.2f%%", self)
    }
    
    var doubleString: String {
        return String(format: "%.2f%", self)
    }
}
