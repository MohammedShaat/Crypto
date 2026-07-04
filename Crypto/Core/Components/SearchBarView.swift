//
//  SearchBarView.swift
//  Crypto
//
//  Created by Mohammed on 7/4/26.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    let onSubmit: (() -> Void)? = nil
    @FocusState private var searchFocus: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle( text.isEmpty ? .theme.secondaryText : .theme.accent)
            
            TextField("Search by name or symbol", text: $text)
                .foregroundStyle(.theme.accent)
                .focused($searchFocus)
                .onSubmit {
                    searchFocus.toggle()
                    onSubmit?()
                }
            
            if !text.isEmpty {
                Image(systemName: "xmark")
                    .padding(.horizontal)
                    .offset(x: -10)
                    .onTapGesture(perform: clear)
            }
        }
        .padding()
        .background(.theme.background)
        .clipShape(.capsule)
        .shadow(color: .theme.accent.opacity(0.5), radius: 5)
    }
    
    func clear() {
        text = ""
        searchFocus.toggle()
    }
}

#Preview {
    SearchBarView(text: .constant(""))
//        .preferredColorScheme(.dark)
}
