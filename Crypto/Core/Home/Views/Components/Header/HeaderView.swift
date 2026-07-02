//
//  HeaderView.swift
//  Crypto
//
//  Created by Mohammed on 6/30/26.
//

import SwiftUI

extension HomeView {
    struct HeaderView: View {
        
        let showProfile: Bool
        let leadingAction: () -> Void
        let trailingAction: () -> Void

        var body: some View {
            HStack {
                Button {
                    leadingAction()
                } label: {
                    HeaderButtonImageView(icon: showProfile ? "plus" : "info")
                }

                Spacer()

                Text(showProfile ? "Profile" : "Prices")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .animation(nil)

                Spacer()

                Button {
                    trailingAction()
                } label: {
                    HeaderButtonImageView(icon: "chevron.right")
                        .rotationEffect(.degrees(showProfile ? 180 : 0))
                        .animation(.easeInOut, value: showProfile)
                }
            }
            .padding()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HomeView.HeaderView(showProfile: false) {
        
    } trailingAction: {
        
    }
}
