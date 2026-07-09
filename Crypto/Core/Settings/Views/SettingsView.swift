//
//  SettingsView.swift
//  Crypto
//
//  Created by Mohammed on 7/9/26.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Swiftful Thinking") {
                    VStack(alignment: .leading) {
                        Image(.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(.rect(cornerRadius: 10))
                        
                        Text("This app was made by following @SwiftfulThinking course on YouTube. It uses MVVM Architecture, async\\await, and SwiftData")
                    }
                    
                    Group {
                        if let youtubeUrl = viewModel.youtubeUrl {
                            Link("Subscribe on YouTube 🥳", destination: youtubeUrl)
                        }
                        
                        if let coffeeUrl = viewModel.nickCoffeeUrl {
                            Link("Support his coffee addiction ☕️", destination: coffeeUrl)
                        }
                    }
                    .foregroundStyle(.blue)
                    .fontWeight(.bold)
                }
                
                Section("Coingecko".uppercased()) {
                    VStack(alignment: .leading) {
                        Image(.coingecko)
                            .resizable()
                            .scaledToFit()
                            .frame(width: .infinity)
                        
                        Text("This cryptocurrency data used in this app comes from a free API from CoinGecko. Prices may be slightly delayed.")
                    }
                    
                    if let coingeckoUrl = viewModel.coingeckoUrl {
                        Link("Visit CoinGecko 🥳", destination: coingeckoUrl)
                            .foregroundStyle(.blue)
                            .fontWeight(.bold)
                    }
                }
                
                Section("Developer") {
                    VStack(alignment: .leading) {
                        Image(.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(.rect(cornerRadius: 10))
                        
                        Text("This app was made by developed by Nick. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, async/await, networking, and data persistance.")
                    }
                    
                    if let nickWebsiteUrl = viewModel.nickWebsiteUrl {
                        Link("Visit Website 🌐", destination: nickWebsiteUrl)
                            .foregroundStyle(.blue)
                            .fontWeight(.bold)
                    }
                }
                
                Section("Application".uppercased()) {
                    if let defaultUrl = viewModel.defaultUrl {
                        Group {
                            Link("Terms of Services", destination: defaultUrl)
                            Link("Privacy Policy", destination: defaultUrl)
                            Link("Company Webiste", destination: defaultUrl)
                            Link("Learn More", destination: defaultUrl)
                        }
                        .foregroundStyle(.blue)
                        .fontWeight(.bold)
                    }
                }
            }
            .foregroundStyle(.theme.accent)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dismiss", systemImage: "xmark") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
