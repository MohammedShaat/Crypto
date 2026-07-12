//
//  Color.swift
//  Crypto
//
//  Created by Mohammed on 6/30/26.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var theme: Theme { Theme() }
}

struct Theme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenCustomColor")
    let red = Color("RedCustomColor")
    let secondaryText = Color("SecondaryTextColor")
    let secondaryBackground = Color("SecondaryBackgroundColor")
}
