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
        private let coinImageService = CoinImageService.shared
        let coin: Coin
        let showHoldings: Bool
        private(set) var image: Data?
        private(set) var imageStatus = LoadingStatus.idle
        
        init(coin: Coin, showHoldings: Bool) {
            self.coin = coin
            self.showHoldings = showHoldings
            
            loadImage()
        }
        
        private func loadImage() {
            imageStatus = .loading
            Task {
                let result = await coinImageService.getImage(from: coin.image)
                
                switch result {
                case .success(let data):
                    image = data
                    imageStatus = .success
                    
                case .failure:
                    imageStatus = .failure("Failed to load image")
                }
            }
        }
    }
}
