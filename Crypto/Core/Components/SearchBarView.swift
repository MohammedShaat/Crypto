//
//  SearchBarView.swift
//  Crypto
//
//  Created by Mohammed on 7/4/26.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField(
                "",
                text: $text,
                prompt: Text("Search by name or symbol")
                    .foregroundStyle(.theme.secondaryText)
            )
            .foregroundStyle(.theme.green)
            
            if !text.isEmpty {
                Image(systemName: "xmark")
                    .onTapGesture(perform: clear)
            }
        }
        .padding()
        .background(.theme.background)
        .clipShape(.capsule)
        .shadow(color: .theme.accent, radius: 5)
    }
    
    func clear() {
        text = ""
    }
}

#Preview {
    SearchBarView(text: .constant(""))
//        .preferredColorScheme(.dark)
}
