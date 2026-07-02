//
//  CoinRowView-VIewModel.swift
//  Crypto
//
//  Created by Mohammed on 7/2/26.
//

import Foundation

extension CoinRowView {
    @Observable
    class ViewModel {
        let coin: Coin
        let showHoldings: Bool
        
        init(coin: Coin, showHoldings: Bool) {
            self.coin = coin
            self.showHoldings = showHoldings
        }
    }
}
