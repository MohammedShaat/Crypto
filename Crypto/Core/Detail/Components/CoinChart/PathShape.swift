//
//  CoinPriceChartView.swift
//  Crypto
//
//  Created by Mohammed on 7/8/26.
//

import Charts
import SwiftUI

struct PathShape: Shape {
    let data: [Double]
    
    func path(in rect: CGRect) -> Path {
        guard !data.isEmpty else { return Path() }
        
        let minValue = data.min() ?? 0
        let maxValue = data.max() ?? 0
        let difference = maxValue - minValue
        let lastIndex = Double(data.count - 1)
        
        let yPos = { (price: Double) in
            (maxValue - price) / difference * rect.height
        }
        let xPos = { (index: Double) in
            (index / lastIndex) * rect.width
        }
        
        var path = Path()
        for (index, price) in data.enumerated() {
            let x = xPos(Double(index))
            let y = yPos(price)
            if index == 0 {
                path.move(to: .init(x: x, y: y))
                continue
            }
            path.addLine(to: .init(x: x, y: y))
        }
        
        return path
    }
    
}

#Preview {
    PathShape(data: Preview.coins[0].sparklineIn7d!.price)
    .stroke(.red, style: .init(lineWidth: 1))
    .frame(height: 250)
    .background(.gray.opacity(0.2))
}
