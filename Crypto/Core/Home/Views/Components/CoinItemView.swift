//
//  CoinItemView.swift
//  Crypto
//
//  Created by Mohammed on 7/5/26.
//

import SwiftUI

struct CoinItemView: View {
    let coin: Coin
    
    var body: some View {
        VStack {
            CoinImageView(id: coin.id, imageUrl: coin.image)
                .frame(width: 50, height: 50)
            
            VStack {
                Text(coin.symbol.uppercased())
                    .font(.headline.bold())
                    .foregroundStyle(.theme.accent)
                
                Text(coin.name)
                    .foregroundStyle(.theme.secondaryText)
            }
        }
        .frame(width: 70)
    }
}

#Preview {
    CoinItemView(coin: Preview.coins[0])
}
