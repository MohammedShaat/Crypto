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
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        NavigationStack {
            if viewModel.firstLoadingDone {
                mainView
            } else {
                SplashView()
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
    private var mainView: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
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
                    
                case .success, .refreshing, .refreshFailed:
                    switch viewModel.activeView {
                    case .coins:
                        allCoinsList
                            .transition(.move(edge: .leading))
                        
                    case .profile:
                        profileCoinsList
                            .transition(.move(edge: .trailing))
                    }
                    
                case .loadingFailed(let error):
                    VStack {
                        Image(systemName: "server.rack")
                        Text(error)
                    }
                    .font(.title)
                }
                
                Spacer()
            }
            .background(.theme.background)
            .toolbar(.hidden)
            .sheet(isPresented: $viewModel.showingEditProfile) {
                EditPortfolioView()
            }
            .sheet(isPresented: $viewModel.showingSettingsView) {
                SettingsView()
            }
            .refreshable(action: viewModel.refresh)
            .navigationDestination(for: Coin.self) { coin in
                DetailView(coin: coin)
            }
        }
    }
    
    private var categoriesRow: some View {
        HStack {
            CategoriesItemView(title: "Coin", showSortArrow: viewModel.sortOrder == .rank, isReversed: viewModel.isSortReversed)
                .onTapGesture { viewModel.sort(by: .rank) }
            
            Spacer()
            
            if viewModel.activeView == .profile {
                CategoriesItemView(title: "Holdings", showSortArrow: viewModel.sortOrder == .holdings, isReversed: viewModel.isSortReversed)
                    .onTapGesture { viewModel.sort(by: .holdings) }
            }
            
            CategoriesItemView(title: "Price", showSortArrow: viewModel.sortOrder == .price, isReversed: viewModel.isSortReversed)
                .containerRelativeFrame(.horizontal, alignment: .trailing) { width, _ in
                    width * 0.25
                }
                .onTapGesture { viewModel.sort(by: .price) }
            
            Image(systemName: "arrow.trianglehead.clockwise.rotate.90")
                .rotationEffect(.degrees(viewModel.refreshDegree))
                .animation(
                    .linear(duration: 1.5),
                    value: viewModel.refreshDegree)
                .onTapGesture {
                    Task {
                        await viewModel.refresh()
                    }
                }
                .allowsHitTesting(viewModel.loadingStatus != .refreshing)
        }
        .padding(.horizontal)
        .font(.caption)
        .foregroundStyle(.theme.secondaryText)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(viewModel.coins) { coin in
                NavigationLink(value: coin) {
                    CoinRowView(coin: coin, showHoldings: false)
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(.plain)
    }
    
    private var profileCoinsList: some View {
        Group {
            if viewModel.profileCoins.isEmpty == false {
                List {
                    ForEach(viewModel.profileCoins) { coin in
                        NavigationLink(value: coin) {
                            CoinRowView(coin: coin, showHoldings: true)
                        }
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.theme.background)
                    }
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView(
                    "You don't have any crypto coins yet.",
                    systemImage: "coloncurrencysign",
                    description: Text("Click on + to add coins")
                )
            }
        }
    }
    
    private var marketStatistics: some View {
        Group {
            if horizontalSizeClass == .compact {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        statisticsRow
                    }
                    .onChange(of: viewModel.activeView) {
                        withAnimation {
                            proxy.scrollTo(
                                viewModel.activeView == .profile
                                ? viewModel.statistics.last?.name
                                : viewModel.statistics.first?.name
                                , anchor: .trailing
                            )
                        }
                    }
                }
            } else {
                statisticsRow
            }
        }
    }
    
    private var statisticsRow: some View {
        HStack(alignment: .top) {
            ForEach(viewModel.statistics) { statistic in
                StatisticView(statistic: statistic)
                    .padding(.horizontal, 10)
                    .id(statistic.name)
                
                if statistic.id != viewModel.statistics.last?.id {
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: LocalCoin.self, configurations: config)
    let context = container.mainContext
    
    HomeView(context: context)
        .modelContainer(container)
}
