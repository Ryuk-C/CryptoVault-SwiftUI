//
//  NewsDetailsViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 24/04/2023.
//

import SwiftUI
import Combine
import CoreData

class NewsDetailsViewModel : ObservableObject {
    
    private let viewContext = PersistenceController.shared.viewContext

    let container: NSPersistentContainer
    @Published var newsDatabase: [NewsDatabase] = []
    @Published var ccc: [CryptoCurrenciesDB] = []

    
    init() {

        container = NSPersistentContainer(name: "CryptoVaultDatabase")

        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Container load failed: \(error)")
            } else {
                print("Succesfully loaded data!")
            }
        }

    }
    
    func addNewsToCoreData(id: String, title: String, imageUrl: String, source: String, date: String) {

        let news = NewsDatabase(context: viewContext)
        news.id = id
        news.title = title
        news.imageUrl = imageUrl
        news.source = source
        news.date = date
                        
        saveData()

    }
    
    private func saveData() {

        do {

            try container.viewContext.save()

        } catch let error {

            print("Error Saving : \(error)")

        }
    }
}
