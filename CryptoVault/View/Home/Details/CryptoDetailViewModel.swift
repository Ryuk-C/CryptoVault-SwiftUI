//
//  CryptoDetailViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 10/05/2023.
//

import Foundation
import Combine

class CryptoDetailViewModel: ObservableObject {

    @Published var loading = false
    @Published var showAlert = false
    @Published var message: String = ""
    @Published var success: String = ""
    @Published var cryptoDetailList = [CryptoDetailModel]()

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol

    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
    }

    func fetchCryptoList(id: String) {

        loading = true
        showAlert = false

        dataManager.fetchCryptoDetail(id: id)
            .sink { dataResponse in

                print("xxx")
                print(dataResponse.value)
                print("xxx")
            if dataResponse.error == nil {

                self.cryptoDetailList = [dataResponse.value!]
                self.success = "OK"
                self.showAlert = false
                self.loading = false
            } else {

                self.loading = false
                self.message = "Oops, something went wrong. Please try again later."
                self.showAlert = true
            }
        }.store(in: &cancellableSet)
    }

    func createAlert(with error: NetworkError) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }

}
