//
//  Header-ButtonImageView.swift
//  Crypto
//
//  Created by Mohammed on 6/30/26.
//

import SwiftUI

struct HeaderButtonImageView: View {
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .frame(width: 20, height: 20)
            .padding(10)
            .foregroundStyle(.primary)
            .background(.theme.background)
            .clipShape(.circle)
            .shadow(color: .theme.accent, radius: 5)
    }
}

#Preview {
    HeaderButtonImageView(icon: "info")
}
