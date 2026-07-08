//
//  CoinPriceChartView.swift
//  Crypto
//
//  Created by Mohammed on 7/8/26.
//

import Charts
import SwiftUI

struct Price: Identifiable, Hashable {
    var id = UUID()
    var value: Double
    var index: Int
}

struct CoinPriceChartView: View {
    let data: [Double]
    var color: Color = .theme.green
    
    private var minPrice: Double {
        data.min() ?? 0
    }
    private var maxPrice: Double {
        data.max() ?? 0
    }
    private var midPrice: Double {
        minPrice + (maxPrice - minPrice) / 2
    }
    private var lastIndex: Int {
        data.count - 1
    }
    
    @State private var items = [Price]()
    var body: some View {
        
        Chart(items, id: \.self) { price in
            LineMark(
                x: .value("Index", price.index),
                y: .value(price.value.toString, price.value)
            )
            .foregroundStyle(color)
            .shadow(color: color, radius: 10)
        }
        .chartXAxis {
            AxisMarks(values: [0, lastIndex]) { value in
                if let value = value.as(Int.self) {
                    AxisValueLabel(anchor: value == 0 ? .topLeading : .topTrailing) {
                        VStack {
                            Text("🌎")
                            Text("\(value)")
                        }
                    }
                }
                AxisGridLine()
            }
        }
        .chartYAxis {
            AxisMarks(values: [minPrice, midPrice, maxPrice]) { price in
                if let price = price.as(Double.self) {
                    AxisValueLabel {
                        Text("\(price.asAbreviatedCurrency)")
                    }
                }
                AxisGridLine()
            }
        }
        .chartYScale(domain: (minPrice)...(maxPrice))
        .frame(height: 200)
        .onAppear {
            Task {
                var counter = 0
                for price in data {
                    items.append(Price(value: price, index: counter))
                    counter += 1
                    try? await Task.sleep(for: .seconds(0.01))
                }
            }
        }
    }
}

#Preview {
    CoinPriceChartView(
        data: Preview.coins[0].sparklineIn7d!.price
    )
}
