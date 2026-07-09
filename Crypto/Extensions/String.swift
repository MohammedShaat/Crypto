//
//  String.swift
//  Crypto
//
//  Created by Mohammed on 7/9/26.
//

import Foundation

extension String {
    var toDate: Date? {
        DateFormatter.isoFormatter.date(from: self)
    }
}
