//
//  ContentView.swift
//  Crypto
//
//  Created by Mohammed on 6/30/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
            
            VStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.theme.accent)
                
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.theme.green)
                
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.theme.red)
                
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.theme.secondaryText)
            }
        }
    }
}

#Preview {
    ContentView()
}
