//
//  CoinRowView-VIewModel.swift
//  Crypto
//
//  Created by Mohammed on 7/2/26.
//

import Foundation

extension CoinImageView {
    @Observable
    class ViewModel {
        private let coinImageService = CoinImageService.shared
        let id: String
        let imageUrl: String
        private(set) var image: Data?
        private(set) var loadingStatus = LoadingStatus.idle
        
        init(id: String, imageUrl: String) {
            self.id = id
            self.imageUrl = imageUrl
            
            loadImage()
        }
        
        private func loadImage() {
            loadingStatus = .loading
            Task {
                let result = await coinImageService.getImage(for: id, from: imageUrl)
                
                switch result {
                case .success(let data):
                    image = data
                    loadingStatus = .success
                    
                case .failure:
                    loadingStatus = .failure("Failed to load image")
                }
            }
        }
    }
}
