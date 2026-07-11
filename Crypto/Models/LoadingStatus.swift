//
//  LoadingStatus.swift
//  Crypto
//
//  Created by Mohammed on 7/2/26.
//

import Foundation

enum LoadingStatus: Equatable {
    case idle, loading, success, loadingFailed(String), refreshing, refreshFailed(String)
}
