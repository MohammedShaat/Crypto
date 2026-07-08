//
//  StatisticView.swift
//  Crypto
//
//  Created by Mohammed on 7/4/26.
//

import SwiftUI

struct StatisticView: View {
    let statistic: Statistic
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(statistic.name)
                .foregroundStyle(.theme.secondaryText)
                .font(.subheadline)
            
            Text(statistic.value)
                .foregroundStyle(.theme.accent)
                .font(.headline)
            
            if let percentage = statistic.percentage {
                Label(
                    percentage.asPercentage,
                    systemImage: percentage >= 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
                )
                .font(.subheadline.bold())
                .foregroundStyle(percentage >= 0 ? .theme.green : .theme.red)
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    HStack {
        StatisticView(statistic: Preview.statistics[0])
            .preferredColorScheme(.dark)
        Spacer()
        
        StatisticView(statistic: Preview.statistics[1])
            .preferredColorScheme(.dark)
        Spacer()
        
        StatisticView(statistic: Preview.statistics[2])
            .preferredColorScheme(.dark)
    }
}
