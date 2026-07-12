//
//  CryptoApp.swift
//  Crypto
//
//  Created by Mohammed on 6/30/26.
//

import SwiftData
import SwiftUI

@main
struct CryptoApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            HomeView(context: container.mainContext)
        }
        .modelContainer(container)
    }
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        
        do {
            try container = ModelContainer(for: LocalCoin.self)
        } catch {
            fatalError("Failed to create model container")
        }
    }
}
