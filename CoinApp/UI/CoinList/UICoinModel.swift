//
//  UICoinModel.swift
//  CoinApp
//
//  Created by Angie Mugo on 14/01/2025.
//

class UICoinModel: Equatable, Hashable {
    let id: String
    let name: String
    let price: String
    var isFavorite: Bool
    let currentPerformance: String
    let icon: String

    init(coinModel: CoinModel, isFavorite: Bool) {
        id = coinModel.id
        name = coinModel.name
        price = coinModel.price
        currentPerformance = coinModel.currentPerformance
        icon = coinModel.iconUrl
        self.isFavorite = isFavorite
    }

    static func == (lhs: UICoinModel, rhs: UICoinModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
