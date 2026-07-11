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
                case .success, .refreshing, .refreshFailed:
                    detailsIfno
                case .loadingFailed(let error):
                    VStack {
                        Image(systemName: "server.rack")
                        Text(error)
                    }
                    .font(.title)
                }
            }
        }
        .background(.theme.background)
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
            
            VStack(alignment: .leading) {
                overview
                additionalDetails
                Divider()
                links
            }
            .font(.title2.bold())
            .foregroundStyle(.theme.accent)
        }
        .padding()
    }
    
    private var description: some View {
        Group {
            if let coinDescription = viewModel.description {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(viewModel.isDescriptionExpanded ? nil : 4)
                        .animation(.easeInOut(duration: 0.6), value: viewModel.isDescriptionExpanded)
                        .onTapGesture(perform: viewModel.expandDescription)
                        .allowsHitTesting(viewModel.isDescriptionExpanded)
                    
                    Button(action: viewModel.expandDescription) {
                        Text(viewModel.isDescriptionExpanded ? "Show Less" : "Show More")
                            .foregroundStyle(.blue)
                    }
                }
                .font(.body)
            }
        }
    }
    
    private var overview: some View {
        VStack(alignment: .leading) {
            Text("Overview")
            Divider()
            description
                .padding(.bottom)
            GridView(items: viewModel.overviewStatistics)
        }
    }
    
    private var additionalDetails: some View {
        VStack(alignment: .leading) {
            Text("Additional Details")
            Divider()
            GridView(items: viewModel.additionalStatistics)
        }
        .padding(.vertical)
    }
    
    private var links: some View {
        VStack(alignment: .leading) {
            if let website = viewModel.websiteUrl, let url = URL(string: website) {
                Link("Website", destination: url)
            }
            if let reddit = viewModel.redditUrl, let url = URL(string: reddit) {
                Link("Reddit", destination: url)
            }
        }
        .font(.body)
        .foregroundStyle(.blue)
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: Preview.coins[0])
    }
}
