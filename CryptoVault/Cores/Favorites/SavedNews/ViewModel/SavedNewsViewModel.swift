//
//  SavedNewsViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 28/04/2023.
//

import Foundation

final class SavedNewsViewModel: ObservableObject {
    
    @Published internal var favNews: [NewsDatabase] = []
    
    func getFavNews() {
        self.favNews = CoreDataManager.shared.fetchFavoriteNews() ?? []
    }
}
