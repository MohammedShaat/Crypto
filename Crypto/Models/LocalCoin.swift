//
//  File.swift
//  Crypto
//
//  Created by Mohammed on 7/5/26.
//

import Foundation
import SwiftData

@Model
class LocalCoin {
    var id: String
    var currentHoldings: Double
    
    init (id: String, currentHoldings: Double) {
        self.id = id
        self.currentHoldings = currentHoldings
    }
}
