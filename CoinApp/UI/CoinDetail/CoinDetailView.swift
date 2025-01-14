//
//  CoinDetailView.swift
//  CoinApp
//
//  Created by Angie Mugo on 09/01/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct CoinDetailView: View {
    @StateObject var viewModel: CoinDetailViewModel

    var body: some View {
        VStack {
            switch viewModel.coinDetailState {
            case .loading:
                ProgressView("Loading coin details...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()

            case .error(let error):
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()

            case .loaded(let detail):
                List {
                    HStack {
                        if let iconURL = URL(string: detail.iconUrl) {
                            WebImage(url: iconURL)
                                .resizable()
                                .frame(width: 50, height: 50)
                        }

                        VStack(alignment: .leading) {
                            Text(detail.name)
                                .font(.title)
                                .padding(.bottom, 5)
                            HStack {
                                Text(detail.symbol)
                                    .font(.subheadline)
                                    .padding(.bottom, 5)

                                Text("#: \(detail.rank)")
                                    .padding(.bottom, 10)
                            }
                        }
                        Spacer()
                        VStack {
                            Text(detail.price.formattedCurrency(currencySymbol: "$"))
                                .font(.headline)
                                .padding(.bottom, 5)

                            Text("\(detail.change)")
                                .font(.headline)
                        }
                    }

                    PerformanceChart(viewModel: viewModel)


                    Text("What is \(detail.name)?")
                        .font(.headline)
                    Text(detail.description)
                        .padding()

                    Text("Stats")
                        .font(.headline)
                        .padding(.top, 20)

                    StatsRow(imageName: "trophy", title: "Rank", value: "#\(detail.rank)")
                    StatsRow(imageName: "chart.pie", title: "Market Cap", value: "\(detail.marketCap.formattedCurrency())")
                    StatsRow(imageName: "chart.bar", title: "Trading Volume", value: "\(detail.tradingVolume.formattedCurrency())")
                    StatsRow(imageName: "arrow.up", title: "All Time High", value: "\(detail.allTimeHigh.price.formattedCurrency())")
                    StatsRow(imageName: "trophy", title: "Exchange Listings", value: "\(detail.numberOfExchanges)")

                    Text("Categories")
                        .font(.headline)
                        .padding(.top, 20)
                    HStack {
                        ForEach(detail.tags, id: \.self) { tag in
                            Text("#\(tag)")
                                .padding(5)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                                .padding(.bottom, 5)
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.loadCoins()
        }
    }
}

#Preview {
    CoinDetailView(viewModel: CoinDetailViewModel(dataSource: LocalDataSource(), coinId: ""))
}
