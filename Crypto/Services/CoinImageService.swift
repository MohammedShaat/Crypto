//
//  CoinImageService.swift
//  Crypto
//
//  Created by Mohammed on 7/2/26.
//

import Foundation
import UniformTypeIdentifiers

struct CoinImageService {
    static let shared = CoinImageService()
    
    private let fmService = FileManagerService.shared
    private let directoryName = "CoinImages"
    
    private init() { }
    
    func getImage(for key: String, from url: String) async -> Result<Data, Error> {
        guard let directory = fmService.createDirectory(for: directoryName, conformingTo: .caches) else {
            print("Failed to find or create cache directory")
            return .failure(FileError.directoryNotFound)
        }
        
        if let data = fmService.getData(for: key, from: directory) {
            return .success(data)
        }
        
        let result = await NetworkService.fetchData(from: url)
        switch result {
        case .success(let data):
            fmService.saveData(data, for: key, to: directory)
            return .success(data)
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
