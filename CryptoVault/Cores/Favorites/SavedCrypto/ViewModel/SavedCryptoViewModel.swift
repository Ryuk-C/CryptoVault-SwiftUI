//
//  SavedCryptoViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 28/04/2023.
//

import Combine
import Foundation

final class SavedCryptoViewModel: ObservableObject {

    @Published internal var favCrypto: [CryptoDatabase] = []
    @Published var loading = false
    @Published var showAlert = false
    @Published var message: String = ""
    @Published var success: String = ""
    @Published var cryptoList = [CustomCryptoMarketModelElement]()

    func getFavNews() {
        self.favCrypto = CoreDataManager.shared.fetchFavoriteCrypto() ?? []

        var idList = ""

        for index in favCrypto {
            guard let id = index.id else {return}
            idList.append("\(id+",")")
        }

        fetchCryptoList(ids: idList, currency: Currencies.USD)
    }

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol

    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
    }

    func fetchCryptoList(ids: String, currency: Currencies) {

        loading = true
        showAlert = false

        dataManager.fetchCustomCryptoMarketList(ids: ids, currency: currency)
            .sink { dataResponse in

            if dataResponse.error == nil {
                self.cryptoList.removeAll()
                self.cryptoList = dataResponse.value!
                self.success = "OK"
                self.showAlert = false
                self.loading = false
            } else {
                self.loading = false
                self.message = "Oops, something went wrong. Please try again later."
                self.showAlert = true
            }
        }
            .store(in: &cancellableSet)
    }
}
