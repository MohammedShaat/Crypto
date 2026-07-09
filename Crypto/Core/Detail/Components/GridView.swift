//
//  SwiftUIView.swift
//  Crypto
//
//  Created by Mohammed on 7/8/26.
//

import SwiftUI

struct GridView: View {
    let items: [Statistic]
    let columns: [GridItem]  = [
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity), alignment: .leading),
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity), alignment: .leading),
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
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
        GridView(items: Preview.statistics)
        
        GridView(items: Preview.statistics)
    }
    .padding()
}
