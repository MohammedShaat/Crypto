//
//  CoinImageService.swift
//  Crypto
//
//  Created by Mohammed on 7/2/26.
//

import Foundation

struct CoinImageService {
    static let shared = CoinImageService()
    private init() { }
    
    func getImage(from url: String) async -> Result<Data, NetworkError> {
        await NetworkService.fetchData(from: url)
    }
}
