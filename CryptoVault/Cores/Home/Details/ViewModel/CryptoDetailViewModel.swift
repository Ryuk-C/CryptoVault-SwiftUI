//
//  CryptoDetailViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 10/05/2023.
//

import Combine
import Foundation

final class CryptoDetailViewModel: ObservableObject {

    @Published var loading = false
    @Published var showAlert = false
    @Published var cryptoSaved = false
    @Published var message: String = ""
    @Published var success: String = ""
    @Published var usdPrice: Double = 0.0
    @Published var usdPriceChange: String = ""
    @Published var eurPrice: Double = 0.0
    @Published var eurPriceChange: String = ""
    @Published var tryliraPrice: Double = 0.0
    @Published var tryPriceChange: String = ""
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

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) {

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

                for i in self.cryptoDetailList{

                    if let usd = i.marketData?.currentPrice?["usd"] {

                        self.usdPrice = usd

                    }

                    if let eur = i.marketData?.currentPrice?["eur"] {

                        self.eurPrice = eur

                    }

                    if let turkishLira = i.marketData?.currentPrice?["try"] {

                        self.tryliraPrice = turkishLira

                    }

                    if let usdChange = i.marketData?.priceChange24HInCurrency?["usd"] {

                        self.usdPriceChange = String(format: "%.3f", usdChange)


                    }

                    if let eurChange = i.marketData?.priceChange24HInCurrency?["eur"] {

                        self.eurPriceChange = String(format: "%.3f", eurChange)


                    }

                    if let tryChange = i.marketData?.priceChange24HInCurrency?["try"] {

                        self.tryPriceChange = String(format: "%.3f", tryChange)

                    }

                }

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
