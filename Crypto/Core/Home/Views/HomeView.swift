//
//  ContentView.swift
//  Crypto
//
//  Created by Mohammed on 6/30/26.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(showProfile: viewModel.activeView == .profile) {
                    
                } trailingAction: {
                    withAnimation {
                        viewModel.switchView()
                    }
                }
                
                categoriesRow
                
                Spacer()
                
                switch viewModel.loadingStatus {
                case .idle:
                    Text("Welcome")
                        .font(.title)
                    
                case .loading:
                    ProgressView()
                    
                case .success:
                    switch viewModel.activeView {
                    case .coins:
                        allCoinsList
                            .transition(.move(edge: .leading))
                    case .profile:
                        profileCoinsList
                            .transition(.move(edge: .trailing))
                    }
                    
                case .failure(let error):
                    VStack {
                        Image(systemName: "server.rack")
                        Text(error)
                    }
                    .font(.title)
                }
                
                Spacer()
            }
            .toolbar(.hidden)
        }
    }
}

extension HomeView {
    private var categoriesRow: some View {
        HStack {
            Text("Coin")
            
            Spacer()

            if viewModel.activeView == .profile {
                Text("Hodlings")
            }
            
            Text("Price")
                .containerRelativeFrame(.horizontal, alignment: .trailing) { width, _ in
                    width * 0.25
                }
        }
        .padding(.horizontal)
        .font(.caption)
        .foregroundStyle(.theme.secondaryText)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(viewModel.coins) { coin in
                CoinRowView(coin: coin, showHoldings: false)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .listStyle(.plain)
    }
    
    private var profileCoinsList: some View {
        List {
            CoinRowView(coin: viewModel.coins[0], showHoldings: true)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            CoinRowView(coin: viewModel.coins[5], showHoldings: true)
                .transition(.move(edge: .trailing))
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
    }
}

#Preview {
    HomeView()
}
