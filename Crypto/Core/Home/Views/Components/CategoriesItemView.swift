//
//  SortArrowView.swift
//  Crypto
//
//  Created by Mohammed on 7/7/26.
//

import SwiftUI

struct CategoriesItemView: View {
    let title: String
    let showSortArrow: Bool
    let isReversed: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
            
            Image(systemName: "chevron.up")
                .rotationEffect(.degrees(isReversed ? -180 : 0))
                .animation(.default, value: isReversed)
                .opacity(showSortArrow ? 1 : 0)
        }
    }
}

#Preview {
    HStack(spacing: 100) {
        CategoriesItemView(title: "coin", showSortArrow: true, isReversed: false)
        
        CategoriesItemView(title: "holdings", showSortArrow: true, isReversed: true)
    }
}
