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
    }
    
    init(coin: Coin) {
        let viewModel = ViewModel(coin: coin)
        _viewModel = State(initialValue: viewModel)
    }
}

extension DetailView {
    private var detailsIfno: some View {
        Group {
            Spacer()
                .frame(height: 150)
            
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
