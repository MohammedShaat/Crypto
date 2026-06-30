//
//  ContentView.swift
//  Crypto
//
//  Created by Mohammed on 6/30/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("HomeView")
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Live Pirces")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Label("Profile", systemImage: "chevron.right")
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Label("Profile", systemImage: "chevron.right")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
