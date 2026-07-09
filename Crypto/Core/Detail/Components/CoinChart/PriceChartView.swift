//
//  PriceChartView.swift
//  Crypto
//
//  Created by Mohammed on 7/9/26.
//

import SwiftUI

struct PriceChartView: View {
    let progress: Double
    
    private let prices: [Double]
    private let minPrice: Double
    private let maxPrice: Double
    private let midPrice: Double
    private let startDate: Date
    private let endDate: Date
    private let color: Color
    
    var body: some View {
        VStack {
            PathShape(data: prices)
                .trim(from: 0, to: progress)
                .stroke(color, style: .init(lineWidth: 2, lineJoin: .round))
                .shadow(color: color, radius: 10, x: 10)
                .background(lines)
                .overlay(yAxisMarks, alignment: .leading)
            
            HStack {
                Text(startDate.toString)
                Spacer()
                Text(endDate.toString)
            }
        }
        .font(.caption)
        .foregroundStyle(.theme.secondaryText)
    }
    
    init(coin: Coin, progress: Double) {
        self.prices = coin.sparklineIn7d?.price ?? []
        self.progress = progress
        
        let minPrice = prices.min() ?? 0
        let maxPrice = prices.max() ?? 0
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.midPrice = minPrice + (maxPrice - minPrice) / 2
        
        let endDate = coin.lastUpdated?.toDate ?? .now
        self.endDate = endDate
        self.startDate = Calendar.current.dateBySubtracting(days: 7, from: endDate) ?? .now
        
        self.color = (coin.priceChangePercentage24h ?? 0) >= 0 ? .theme.green : .theme.red
    }
}

extension PriceChartView {
    private var lines: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var yAxisMarks: some View {
        VStack {
            Text(maxPrice.asAbreviatedCurrency)
            Spacer()
            Text(midPrice.asAbreviatedCurrency)
            Spacer()
            Text(minPrice.asAbreviatedCurrency)
        }
    }
}

#Preview {
    @Previewable @State var progress = 1.0
    
    PriceChartView(coin: Preview.coins[0], progress: progress)
        .frame(height: 250)
//        .background(.blue.opacity(0.2))
        .onAppear {
            withAnimation(.linear(duration: 3)) {
                progress = 1
            }
        }
}
