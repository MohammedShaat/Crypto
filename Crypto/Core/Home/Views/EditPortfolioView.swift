//
//  EditPortfolioView.swift
//  Crypto
//
//  Created by Mohammed on 7/5/26.
//

import SwiftUI

struct EditPortfolioView: View {
    
    @Environment(HomeView.ViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var holdingsFocus: Bool
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        NavigationStack {
            ScrollView {
                VStack {
                    SearchBarView(text: $viewModel.searchText)
                        .padding()
                    
                    switch viewModel.loadingStatus {
                    case .idle:
                        Text("Welcome")
                            .font(.title)
                        
                    case .loading:
                        ProgressView()
                        
                    case .success:
                        coinsList
                        fields
                        
                    case .failure(let error):
                        VStack {
                            Image(systemName: "server.rack")
                            Text(error)
                        }
                        .font(.title)
                    }
                    
                }
            }
            .navigationTitle("Edit Portfolio")
            .scrollBounceBehavior(.basedOnSize)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("cancel", systemImage: "xmark") {
                        dismiss()
                    }
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    if viewModel.showingSaveIcon {
                        Image(systemName: "checkmark")
                    }
                    
                    if viewModel.showingSaveButton {
                        Button("Save") {
                            holdingsFocus = false
                            viewModel.save()
                        }
                    }
                }
            }
        }
    }
}

extension EditPortfolioView {
    private var coinsList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 30) {
                ForEach(viewModel.coins) { coin in
                    CoinItemView(coin: coin)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.theme.green, lineWidth: 1)
                            .foregroundStyle(.theme.green)
                            .opacity(viewModel.tappedCoin?.id == coin.id ? 1 : 0)
                    )
                    .onTapGesture {
                        viewModel.coinTapped(coin)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var fields: some View {
        VStack {
            @Bindable var viewModel = viewModel
            
            if let coin = viewModel.tappedCoin {
                Group {
                    HStack {
                        Text("Current price of \(coin.symbol.uppercased()):")
                        Spacer()
                        Text(coin.currentPrice.asCurrency)
                    }
                    Divider()
                    
                    HStack {
                        Text("Amount holding:")
                        Spacer()
                        TextField(
                            coin.currentHoldings != nil
                            ? "\(coin.currentHoldings ?? 0)"
                            : "Ex: 1.2",
                            value: $viewModel.newHoldings,
                            format: .number
                        )
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .containerRelativeFrame(.horizontal, alignment: .trailing) { width, _ in
                            width * 0.2
                        }
                        .focused($holdingsFocus)
                        .onChange(of: viewModel.newHoldings, viewModel.newHoldingsChanged)
                    }
                    Divider()
                    
                    HStack {
                        Text("Current value:")
                        Spacer()
                        Text(viewModel.totalHoldings.asAbreviatedCurrency)
                    }
                }
                .fontWeight(.bold)
                .padding(.vertical, 7)
            }
        }
        .padding(.horizontal)
        .padding(.top, 50)
    }
}

#Preview {
    VStack {
        
    }
    .sheet(isPresented: .constant(true)) {
        EditPortfolioView()
    }
    .environment(HomeView.ViewModel())
}
