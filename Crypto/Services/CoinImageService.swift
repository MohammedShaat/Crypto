//
//  CoinImageService.swift
//  Crypto
//
//  Created by Mohammed on 7/2/26.
//

import Foundation

struct CoinImageService {
    private init() { }
    
    static func getImage(from url: String) async -> Result<Data, NetworkError> {
        await NetworkService.fetchData(from: url)
    }
}
