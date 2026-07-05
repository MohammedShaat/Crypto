//
//  CoinImageView.swift
//  Crypto
//
//  Created by Mohammed on 7/5/26.
//

import SwiftUI

struct CoinImageView: View {
    
    @State private var viewModel: ViewModel
    
    var body: some View {
        Group {
            if viewModel.loadingStatus == .loading {
                ProgressView()
            } else {
                getImage(for: viewModel.loadingStatus)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
    
    init(id: String, imageUrl: String) {
        let viewModel = ViewModel(id: id, imageUrl: imageUrl)
        _viewModel = State(initialValue: viewModel)
    }

    func getImage(for status: LoadingStatus) -> Image {
        switch viewModel.loadingStatus {
        case .idle:
            return Image(systemName: "photo.slash")
        case .loading:
            return Image(systemName: "photo.circle.fill")
        case .success:
            guard let data = viewModel.image, let uiImage = UIImage(data: data) else {
                return Image(systemName: "")
            }
            return Image(uiImage: uiImage)
            
        case .failure:
            return Image(systemName: "exclamationmark.triangle.fill")
        }
    }
}

#Preview {
    let coin = Preview.coins[2]
    
    return CoinImageView(id: coin.id, imageUrl: coin.image)
}
