//
//  ContentView.swift
//  Crypto
//
//  Created by Mohammed on 6/30/26.
//

import SwiftUI

struct HomeView: View {
    @State private var showProfile = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(showProfile: showProfile) {
                    
                } trailingAction: {
                    showProfile.toggle()
                }
                
                ScrollView {
                    
                }
            }
            .toolbar(.hidden)
        }
    }
}

#Preview {
    HomeView()
}
