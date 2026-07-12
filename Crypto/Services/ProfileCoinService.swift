//
//  ProfileCoinsService.swift
//  Crypto
//
//  Created by Mohammed on 7/5/26.
//

import Foundation
import SwiftData

struct ProfileCoinService {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchCoins() -> Result<[LocalCoin], Error> {
        SwiftDataService.shared.fetchData(context: context)
    }
    
    func addCoin(_ coin: LocalCoin) {
        SwiftDataService.shared.addItem(coin, context: context)
    }
    
    func deleteCoin(_ coin: LocalCoin) {
        SwiftDataService.shared.deleteItem(coin, context: context)
    }
}
