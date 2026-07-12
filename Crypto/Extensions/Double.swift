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
    
    var twoDecimal: String {
        self.formatted(.number.precision(.fractionLength(2)))
    }
    
    var asAbreviatedCurrency: String {
        /*
         10 -> 10
         10,847 -> 10.84k
         10,847,000 -> 10.84M
         10,847,000,000 -> 10.84B
         10,847,000,000,000 -> 10.84T
         */

        let compactNum = switch self {
        case 1_000..<1_000_000:
            Double(self / 1_000).twoDecimal + "K"
            
        case 1_000_000..<1_000_000_000:
            Double(self / 1_000_000).twoDecimal + "M"
            
        case 1_000_000_000..<1_000_000_000_000:
            Double(self / 1_000_000_000).twoDecimal + "B"
            
        case 1_000_000_000_000..<1_000_000_000_000_000:
            Double(self / 1_000_000_000_000).twoDecimal + "T"
            
        default:
            self.twoDecimal
        }
        
        return "$\(compactNum)"
    }
}

extension Double? {
    var asPercentage: String {
        (self ?? 0).asPercentage
    }
}
