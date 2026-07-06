//
//  ContentView.swift
//  Crypto
//
//  Created by Mohammed on 6/30/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(showProfile: viewModel.activeView == .profile) {
                    viewModel.topLeadingButtonTapped()
                } trailingAction: {
                    withAnimation {
                        viewModel.switchView()
                    }
                }
                
                marketStatistics
                
                SearchBarView(text: $viewModel.searchText)
                    .padding()
                
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
            .sheet(isPresented: $viewModel.showingEditProfile) {
                EditPortfolioView()
            }
        }
        .environment(viewModel)
    }
    
    init(context: ModelContext) {
        let viewModel = ViewModel(context: context)
        _viewModel = State(initialValue: viewModel)
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
            ForEach(viewModel.profileCoins) { coin in
                CoinRowView(coin: coin, showHoldings: true)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .listStyle(.plain)
    }
    
    private var marketStatistics: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                ForEach(viewModel.statistics) { statistic in
                    StatisticView(statistic: statistic)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: LocalCoin.self, configurations: config)
    let context = container.mainContext
    
    HomeView(context: context)
}
