//
//  Double.swift
//  Crypto
//
//  Created by Mohammed on 7/1/26.
//

import Foundation

extension Double {
    var asCurrency: String {
        self.formatted(.currency(code: "USD"))
    }
    
    var asPercentage: String {
        self.formatted(.number.precision(.fractionLength(2))) + "%"
    }
}

extension Double? {
    var asPercentage: String {
        (self ?? 0).asPercentage
    }
}
