//
//  HomeViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 23/04/2023.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {

    @Published var loading = false
    @Published var showAlert = false
    @Published var message: String = ""
    @Published var success: String = ""
    @Published var cryptoList = [CryptoMarketListElement]()

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol

    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
    }

    func fetchCryptoList(currency: Currencies) {

        loading = true
        showAlert = false

        dataManager.fetchCryptoMarketList(currency: currency)
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

    func createAlert(with error: NetworkError) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}
