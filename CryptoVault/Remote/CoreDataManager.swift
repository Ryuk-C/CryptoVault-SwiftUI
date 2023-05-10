//
//  CoreDataManager.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 26/04/2023.
//

import CoreData
import Foundation

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private let container: NSPersistentContainer
        
    private init() {
        container = NSPersistentContainer(name: "CryptoVaultDatabase")
        container.loadPersistentStores { _, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription) ")
            }
        }
    }
    
    func save() {
        try? container.viewContext.save()
    }


    // MARK: - Favorite News
    func fetchFavoriteNews() -> [NewsDatabase]? {
        let request = NSFetchRequest<NewsDatabase>(entityName: "NewsDatabase")
        return try? container.viewContext.fetch(request)
    }
    
    func addFavoriteNews(newNews: NewsCoreDataModel) {
        let news = NewsDatabase(context: container.viewContext)
        news.id = newNews.id
        news.newsUrl = newNews.newsUrl
        news.title = newNews.title
        news.imageUrl = newNews.imageUrl
        news.source = newNews.source
        news.date = newNews.date

        save()
    }
    
    func deleteFavoriteNews(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        if let favs = fetchFavoriteNews() {
            container.viewContext.delete(favs[index])
            save()
        }
    }
    
    func isAlreadyFavoritedNews(news: NewsCoreDataModel) -> Bool {
        if fetchFavoriteNews()?.contains(where: { $0.id == news.id }) == true {
            return true
        } else {
            return false
        }
    }

    // MARK: - Favorite Crypto
    func fetchFavoriteCrypto() -> [CryptoDatabase]? {
        let request = NSFetchRequest<CryptoDatabase>(entityName: "CryptoDatabase")
        return try? container.viewContext.fetch(request)
    }

    func addFavoriteCrypto(newCrypto: CryptoCoreDataModel) {
        let crypto = CryptoDatabase(context: container.viewContext)
        crypto.id = newCrypto.id
        crypto.name = newCrypto.name
        crypto.price = newCrypto.price

        save()
    }

    func deleteFavoriteCrypto(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        if let favs = fetchFavoriteCrypto() {
            container.viewContext.delete(favs[index])
            save()
        }
    }

    func isAlreadyFavoritedCrypto(crypto: CryptoCoreDataModel) -> Bool {
        if fetchFavoriteCrypto()?.contains(where: { $0.name == crypto.name }) == true {
            return true
        } else {
            return false
        }
    }
}
