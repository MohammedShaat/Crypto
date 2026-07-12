//
//  Date.swift
//  Crypto
//
//  Created by Mohammed on 7/9/26.
//

import Foundation

extension Date {
    var toString: String {
        DateFormatter.shortFormatter.string(from: self)
    }
}

extension DateFormatter {
    static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFractionalSeconds, .withInternetDateTime]
        return formatter
    }()
    
    static let shortFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yy"
        return formatter
    }()
}

extension Calendar {
     func dateBySubtracting(days: Int, from date: Date) -> Date? {
        Calendar.current.date(byAdding: .day, value: -days, to: date)
    }
}
