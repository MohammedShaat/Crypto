//
//  LaunchView.swift
//  Crypto
//
//  Created by Mohammed on 7/11/26.
//

import SwiftUI

struct SplashView: View {
    let title = ("Loading data")
    @State private var start = 0.0
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Image(.logoTransparent)
            
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    ForEach(Array(title.enumerated()), id: \.offset) { (index, letter) in
                        Text(String(letter))
                            .offset(y: -7 * start)
                            .animation(
                                .easeInOut(duration: 0.4)
                                    .repeatForever()
                                    .delay(Double(index) / 16),
                                value: start)
                    }
                }
                .offset(y: 70)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .foregroundStyle(.launchScreenAccent)
        .onAppear {
            start = 1
        }
    }
}

#Preview {
    SplashView()
}
