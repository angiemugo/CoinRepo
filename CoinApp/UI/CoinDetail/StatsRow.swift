//
//  StatsRow.swift
//  CoinApp
//
//  Created by Angie Mugo on 12/01/2025.
//
import SwiftUI

struct StatsRow: View {
    var imageName: String
    var title: String
    var value: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.purple)
                .imageScale(.large) 
            Text(title)
                .fontWeight(.semibold)
                .font(.body)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
                .font(.body)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}

#Preview {
    StatsRow(imageName: "star.fill", title: "Favorite", value: "100")
}
