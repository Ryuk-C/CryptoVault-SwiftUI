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
    
    func fetchFavorites() -> [NewsDatabase]? {
        let request = NSFetchRequest<NewsDatabase>(entityName: "NewsDatabase")
        return try? container.viewContext.fetch(request)
    }
    
    func addFavorite(newNews: NewsCoreDataModel) {
        let news = NewsDatabase(context: container.viewContext)
        news.id = newNews.id
        news.title = newNews.title
        news.imageUrl = newNews.imageUrl
        news.source = newNews.source
        news.date = newNews.date

        save()
    }
    
    
    func deleteFavorite(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        if let favs = fetchFavorites() {
            container.viewContext.delete(favs[index])
            save()
        }
    }
    
    func isAlreadyFavorited(news: NewsCoreDataModel) -> Bool {
        if fetchFavorites()?.contains(where: { $0.id == news.id }) == true {
            return true
        } else {
            return false
        }
    }
}
