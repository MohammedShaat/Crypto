//
//  CoinRowView.swift
//  Crypto
//
//  Created by Mohammed on 7/1/26.
//

import SwiftUI

struct CoinRowView: View {
    @State private var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.coin.rank, format: .number)
                .foregroundStyle(.theme.secondaryText)
            
            AsyncImage(url: URL(string: viewModel.coin.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            } placeholder: {
                ProgressView()
                    .frame(width: 40, height: 40)
            }
            
            
            
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
            
            Spacer()
            
            // Mid column
            if viewModel.showHoldings {
                VStack(alignment: .trailing) {
                    Text(viewModel.coin.totalCurrentHodldings.asCurrency)
                    
                    Text(viewModel.coin.currentHoldings ?? 0, format: .number)
                }
            }
            
            // Right column
            VStack(alignment: .trailing) {
                Text(viewModel.coin.currentPrice.asCurrency)
                
                Text(viewModel.coin.priceChangePercentage24h.asPercentage)
                    .foregroundStyle(
                        viewModel.coin.priceChangePercentage24h ?? 0 >= 0
                        ? .theme.green
                        : .theme.red
                    )
            }
            .containerRelativeFrame(.horizontal, alignment: .trailing) { width, _ in
                width * 0.25
            }
        }
        .padding()
        .foregroundStyle(.theme.accent)
    }
    
    init(coin: Coin, showHoldings: Bool) {
        let viewModel = ViewModel(coin: coin, showHoldings: showHoldings)
        _viewModel = .init(initialValue: viewModel)
    }
}

#Preview {
    CoinRowView(coin: Preview.coins[0], showHoldings: true)
        .background(.gray.opacity(0.4))
//        .preferredColorScheme(.dark)
    
    CoinRowView(coin: Preview.coins[2], showHoldings: true)
        .background(.gray.opacity(0.4))
}
