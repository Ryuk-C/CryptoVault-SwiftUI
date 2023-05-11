//
//  NewsViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 24/04/2023.
//

import Combine
import Foundation

class NewsViewModel: ObservableObject {

    @Published var loading = false
    @Published var showAlert = false
    @Published var message: String = ""
    @Published var success: Int = 0
    @Published var newsList = [Datum]()

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol

    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
    }

    func fetchNewsList(language: Languages) {

        loading = true
        showAlert = false

        dataManager.fetchLastNews(language: language)
            .sink { dataResponse in

            if dataResponse.error == nil {

                self.success = dataResponse.value!.type

                switch dataResponse.value!.type {

                case 100:
                    self.newsList.removeAll()
                    self.newsList = dataResponse.value!.data

                default:
                    self.showAlert = true
                    self.message = "Oops, something went wrong. Please try again later."
                }
            } else {

                self.message = "Oops, something went wrong. Please try again later."
                self.showAlert = true
            }
                
                self.loading = false
        }
            .store(in: &cancellableSet)
    }

    func createAlert(with error: NetworkError) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}
