//
//  DetailView.swift
//  Crypto
//
//  Created by Mohammed on 7/7/26.
//

import SwiftUI

struct DetailView: View {
    
    @State private var viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.coin.name)
    }
    
    init(coin: Coin) {
        let viewModel = ViewModel(coin: coin)
        _viewModel = State(initialValue: viewModel)
        print("DetailVIew init")
    }
}

#Preview {
    DetailView(coin: Preview.coins[0])
}
