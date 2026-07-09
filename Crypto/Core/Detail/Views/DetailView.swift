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
        ScrollView {
            VStack {
                switch viewModel.loadingStatus {
                case .idle:
                    Text("Coin Detail")
                        .font(.title)
                case .loading:
                    ProgressView()
                case .success, .refreshing:
                    detailsIfno
                case .failure(let error):
                    VStack {
                        Image(systemName: "server.rack")
                        Text(error)
                    }
                    .font(.title)
                }
            }
        }
        .navigationTitle(viewModel.coin.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .principal) {
                CoinImageView(id: viewModel.coin.id, imageUrl: viewModel.coin.image)
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    init(coin: Coin) {
        let viewModel = ViewModel(coin: coin)
        _viewModel = State(initialValue: viewModel)
    }
}

extension DetailView {
    private var detailsIfno: some View {
        Group {
            PriceChartView(coin: viewModel.coin, progress: viewModel.progress)
                .frame(height: 200)
                .onAppear {
                    withAnimation(.easeOut(duration: 2)) {
                        viewModel.incrementProgress()
                    }
                }
            
            GridView(title: "Overview", items: viewModel.overviewStatistics)
            
            GridView(title: "Additional Details", items: viewModel.additionalStatistics)
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: Preview.coins[0])
    }
}
