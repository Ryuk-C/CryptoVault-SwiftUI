//
//  CryptoDetailViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 10/05/2023.
//

import Combine
import Foundation

class CryptoDetailViewModel: ObservableObject {

    @Published var loading = false
    @Published var showAlert = false
    @Published var cryptoSaved = false
    @Published var message: String = ""
    @Published var success: String = ""
    @Published var cryptoDetailList = [CryptoDetailModel]()

    @Published var savedCryptoData: [CryptoDatabase] = []
    @Published internal var favButtonImageName = "star"

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol

    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
    }

    func addCrypto(crypto: CryptoCoreDataModel?) {
        if let crypto, !CoreDataManager.shared.isAlreadyFavoritedCrypto(crypto: crypto) {
            CoreDataManager.shared.addFavoriteCrypto(newCrypto: crypto)
            cryptoSaved.toggle()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {

                self.cryptoSaved.toggle()
            }
        } else {
            if let index = CoreDataManager.shared.fetchFavoriteCrypto()?.firstIndex(where: { $0.id == crypto?.id }) {
                CoreDataManager.shared.deleteFavoriteCrypto(indexSet: .init(integer: index))
            }
        }
    }

    func toggleFavButton() {
        if self.favButtonImageName == "star" {
            favButtonImageName = "star.fill"
        } else {
            favButtonImageName = "star"
        }
    }

    func setFavButtonImage(crypto: CryptoCoreDataModel?) {
        if let crypto, CoreDataManager.shared.isAlreadyFavoritedCrypto(crypto: crypto) {
            self.favButtonImageName = "star.fill"
        } else {
            self.favButtonImageName = "star"
        }
    }

    func fetchCryptoList(id: String) {

        loading = true
        showAlert = false

        dataManager.fetchCryptoDetail(id: id)
            .sink { dataResponse in

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
        }
            .store(in: &cancellableSet)
    }

    func createAlert(with error: NetworkError) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}
