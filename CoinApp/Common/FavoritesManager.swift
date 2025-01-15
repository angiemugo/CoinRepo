//
//  FavoritesManager.swift
//  CoinApp
//
//  Created by Angie Mugo on 13/01/2025.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesKey = "favoriteCoinIDs"

    func getFavoriteIDs() -> [String] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [String] ?? []
    }

    func addFavorite(_ id: String) {
        var favorites = getFavoriteIDs()
        if !favorites.contains(id) {
            favorites.append(id)
            saveFavorites(favorites)
        }
    }

    func removeFavorite(_ id: String) {
        var favorites = getFavoriteIDs()
        favorites.removeAll { $0 == id }
        saveFavorites(favorites)
    }

    private func saveFavorites(_ ids: [String]) {
        UserDefaults.standard.set(ids, forKey: favoritesKey)
    }
}
