//
//  NewsDetailsViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 24/04/2023.
//

import Combine
import CoreData
import SwiftUI
import UIKit

class NewsDetailsViewModel: ObservableObject {
    
    @Published var savedNewsData: [NewsDatabase] = []
    @Published var newsSaved = false
    var removed = false
    @Published internal var favButtonImageName = "bookmark"

    func addNews(news: NewsCoreDataModel?) {
        if let news, !CoreDataManager.shared.isAlreadyFavoritedNews(news: news) {
            CoreDataManager.shared.addFavoriteNews(newNews: news)
            newsSaved.toggle()

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                self.newsSaved.toggle()
            }

        } else {
            if let index = CoreDataManager.shared.fetchFavoriteNews()?.firstIndex(where: { $0.id == news?.id}) {
                CoreDataManager.shared.deleteFavoriteNews(indexSet: .init(integer: index))
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
    
    func setFavButtonImage(news: NewsCoreDataModel?) {
        if let news, CoreDataManager.shared.isAlreadyFavoritedNews(news: news) {
            self.favButtonImageName = "bookmark.fill"
        } else {
            self.favButtonImageName = "bookmark"
        }
    }
}
