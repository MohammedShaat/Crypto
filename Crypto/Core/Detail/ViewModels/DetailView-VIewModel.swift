//
//  DetailView-VIewModel.swift
//  Crypto
//
//  Created by Mohammed on 7/7/26.
//

import Foundation


extension DetailView {
    @Observable
    class ViewModel {
        let coin: Coin
        
        init(coin: Coin) {
            self.coin = coin
        }
    }
}
