//
//  NewsDetailsViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 24/04/2023.
//

import SwiftUI
import Combine
import CoreData
import UIKit

class NewsDetailsViewModel : ObservableObject {
    
    @Published var savedNewsData: [NewsDatabase] = []
    var added: Bool = false
    var removed: Bool = false
    @Published internal var favButtonImageName = "bookmark"

    func addNews(news: NewsCoreDataModel?) {
        if let news, !CoreDataManager.shared.isAlreadyFavorited(news: news) {
            CoreDataManager.shared.addFavorite(newNews: news)
        } else {
            if let index = CoreDataManager.shared.fetchFavorites()?.firstIndex(where: { $0.id == news?.id}) {
                CoreDataManager.shared.deleteFavorite(indexSet: .init(integer: index))
            }
        }
    }
    
    func toggleFavButton() {
        if self.favButtonImageName == "bookmark" {
            favButtonImageName = "bookmark.fill"
        } else {
            favButtonImageName = "bookmark"
        }
    }
    
    func setFavButtonImage(news: NewsCoreDataModel?)  {
        if let news, CoreDataManager.shared.isAlreadyFavorited(news: news) {
            self.favButtonImageName = "bookmark.fill"
            self.added = true
        } else {
            self.favButtonImageName = "bookmark"
            self.added = false
        }
    }
    
}
