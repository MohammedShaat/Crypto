//
//  SwiftDataService.swift
//  Crypto
//
//  Created by Mohammed on 7/5/26.
//

import Foundation
import SwiftData

struct SwiftDataService {
    static let shared = SwiftDataService()

    private init() {}
    
    func fetchData<T: PersistentModel>(context: ModelContext) -> Result<[T], Error> {
        do {
            let data = try context.fetch(FetchDescriptor<T>())
            return .success(data)
        } catch {
            print("Failed to fetch data from SwiftData:\n\(error)")
            return .failure(error)
        }
    }
    
    func addItem<T: PersistentModel>(_ item: T, context: ModelContext) {
        context.insert(item)
    }
    
    func deleteItem<T: PersistentModel>(_ item: T, context: ModelContext) {
        context.delete(item)
    }
}
