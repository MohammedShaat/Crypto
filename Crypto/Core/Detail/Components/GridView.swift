//
//  SwiftUIView.swift
//  Crypto
//
//  Created by Mohammed on 7/8/26.
//

import SwiftUI

struct GridView: View {
    let title: String
    let items: [Statistic]
    let columns: [GridItem]  = [
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity), ),
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity)),
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2.bold())
                .foregroundStyle(.theme.accent)
            Divider()
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 30) {
                ForEach(items) { statistic in
                    StatisticView(statistic: statistic)
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 50) {
        GridView(title: "Current Price", items: Preview.statistics)
        
        GridView(title: "Market Capitalization", items: Preview.statistics)
    }
    .padding()
}
