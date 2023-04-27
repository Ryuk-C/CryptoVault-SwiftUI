//
//  PersistanceManager.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 26/04/2023.
//

import CoreData

struct PersistenceController {
    private static var instance: PersistenceController?
    private static var previewInstance: PersistenceController?

    static var shared: PersistenceController {
        if previewInstance != nil {
            return previewInstance!
        }

        if instance == nil {
            instance = PersistenceController()
        }

        return instance!
    }

    private let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CryptoVaultDatabase")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
