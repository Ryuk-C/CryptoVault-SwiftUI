//
//  SavedCryptoViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 28/04/2023.
//

import Foundation

class SavedCryptoViewModel: ObservableObject {

    @Published internal var favCrypto: [CryptoDatabase] = []

    func getFavNews() {
        self.favCrypto = CoreDataManager.shared.fetchFavoriteCrypto() ?? []
    }
}
