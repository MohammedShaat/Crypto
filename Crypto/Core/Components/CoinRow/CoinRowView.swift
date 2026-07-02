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
            
            image
            
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
            
            Spacer()
            
            if viewModel.showHoldings {
                midColumn
            }
            
            rightColumn
        }
        .padding()
        .foregroundStyle(.theme.accent)
    }
    
    init(coin: Coin, showHoldings: Bool) {
        let viewModel = ViewModel(coin: coin, showHoldings: showHoldings)
        _viewModel = .init(initialValue: viewModel)
    }
}

extension CoinRowView {
    private var image: some View {
        Group {
            if viewModel.imageStatus == .loading {
                ProgressView()
            } else {
                getImage(for: viewModel.imageStatus)
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: 40, height: 40)
    }
    
    func getImage(for status: LoadingStatus) -> Image {
        return switch viewModel.imageStatus {
        case .idle:
            Image(systemName: "photo.slash")
        case .loading:
            Image(systemName: "photo.circle.fill")
        case .success:
            Image(uiImage: UIImage(data: viewModel.image!)!)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
        }
    }
    
    private var midColumn: some View {
        VStack(alignment: .trailing) {
            Text(viewModel.coin.totalCurrentHodldings.asCurrency)
            
            Text(viewModel.coin.currentHoldings ?? 0, format: .number)
        }
    }
    
    private var rightColumn: some View {
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
}

#Preview {
    CoinRowView(coin: Preview.coins[0], showHoldings: true)
        .background(.gray.opacity(0.4))
//        .preferredColorScheme(.dark)
    
    CoinRowView(coin: Preview.coins[2], showHoldings: true)
        .background(.gray.opacity(0.4))
}
