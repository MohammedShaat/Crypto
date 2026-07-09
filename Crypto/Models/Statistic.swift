//
//  Statistic.swift
//  Crypto
//
//  Created by Mohammed on 7/4/26.
//

import Foundation

struct Statistic: Identifiable, Codable {
    let id: UUID
    let name: String
    let value: String
    let percentage: Double?
    
    init(name: String, value: String, percentage: Double? = nil) {
        self.id = UUID()
        self.name = name
        self.value = value
        self.percentage = percentage
    }
}
