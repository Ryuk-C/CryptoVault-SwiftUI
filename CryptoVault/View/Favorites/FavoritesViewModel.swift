//
//  FavoritesViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 26/04/2023.
//

import Foundation

final class FavoriteViewModel: ObservableObject {
    
    @Published internal var favNews: [NewsDatabase] = []
    
    func getFavNews() {
        self.favNews = CoreDataManager.shared.fetchFavorites() ?? []
        print("---")
        print(favNews)
        print("---")
    }
    
    func deleteGame(indexSet: IndexSet) {
       // CoreDataManager.shared.deleteFavorite(indexSet: indexSet)
    }
}
