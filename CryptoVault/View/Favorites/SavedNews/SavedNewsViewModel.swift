//
//  SavedNewsViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 28/04/2023.
//

import Foundation

class SavedNewsViewModel : ObservableObject {
    
    @Published internal var favNews: [NewsDatabase] = []
    
    func getFavNews() {
        self.favNews = CoreDataManager.shared.fetchFavorites() ?? []
    }
    
    func deleteNews(indexSet: IndexSet) {
       CoreDataManager.shared.deleteFavorite(indexSet: indexSet)
    }
    
}