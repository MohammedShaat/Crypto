//
//  SettingsView-ViewModel.swift
//  Crypto
//
//  Created by Mohammed on 7/9/26.
//

import Foundation

extension SettingsView {
    @Observable
    class ViewModel {
        let youtubeUrl = URL(string: "https://www.youtube.com/@SwiftfulThinking")
        let nickCoffeeUrl = URL(string: "https://buymeacoffee.com/nicksarno")
        let coingeckoUrl = URL(string: "https://www.coingecko.com/en/api")
        let nickWebsiteUrl = URL(string: "https://www.swiftful-thinking.com")
        let defaultUrl = URL(string: "https://www.apple.com")
    }
}
