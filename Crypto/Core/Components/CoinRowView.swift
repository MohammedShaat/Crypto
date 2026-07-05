//
//  CoinRowView.swift
//  Crypto
//
//  Created by Mohammed on 7/1/26.
//

import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    let showHoldings: Bool
    
    var body: some View {
        HStack {
            Text(coin.rank, format: .number)
                .foregroundStyle(.theme.secondaryText)
            
            CoinImageView(id: coin.id, imageUrl: coin.image)
                .frame(width: 40, height: 40)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
            
            Spacer()
            
            if showHoldings {
                midColumn
            }
            
            rightColumn
        }
        .padding()
        .foregroundStyle(.theme.accent)
    }
}

extension CoinRowView {
    private var midColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.totalCurrentHodldings.asCurrency)
            
            Text(coin.currentHoldings ?? 0, format: .number)
        }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrency)
            
            Text(coin.priceChangePercentage24h.asPercentage)
                .foregroundStyle(
                    coin.priceChangePercentage24h ?? 0 >= 0
                    ? .theme.green
                    : .theme.red
                )
                .font(.subheadline)
        }
        .containerRelativeFrame(.horizontal, alignment: .trailing) { width, _ in
            width * 0.25
        }
    }
}

#Preview {
    CoinRowView(coin: Preview.coins[0], showHoldings: true)
        .background(.gray.opacity(0.4))
//        .preferredColorScheme(.dark)
    
    CoinRowView(coin: Preview.coins[2], showHoldings: true)
        .background(.gray.opacity(0.4))
}
