//
//  SavedNewsViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 28/04/2023.
//

import Foundation

class SavedNewsViewModel: ObservableObject {
    
    @Published internal var favNews: [NewsDatabase] = []
    
    func getFavNews() {
        self.favNews = CoreDataManager.shared.fetchFavoriteNews() ?? []
    }
    
    func deleteNews(indexSet: IndexSet) {
       CoreDataManager.shared.deleteFavoriteNews(indexSet: indexSet)
    }
}
