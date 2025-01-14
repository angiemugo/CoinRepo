//
//  LoadingView.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

import SwiftUI

struct LoadingView: View {
    @State var loading: Bool = false

    var body: some View {
        ProgressView()
    }
}

#Preview {
    LoadingView(loading: true)
}
