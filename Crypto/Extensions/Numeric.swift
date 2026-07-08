//
//  Numeric.swift
//  Crypto
//
//  Created by Mohammed on 7/8/26.
//

import Foundation

extension Numeric where Self: LosslessStringConvertible {
    var toString: String {
        String(self)
    }
}
