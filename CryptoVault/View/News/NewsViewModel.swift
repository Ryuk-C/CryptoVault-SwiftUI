//
//  NewsViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 24/04/2023.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {

    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
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
            .sink { (dataResponse) in

            if dataResponse.error == nil {

                self.success = dataResponse.value!.type

                if self.success == 100 {
                    self.newsList = dataResponse.value!.data
                }

                self.showAlert = false
                self.loading = false

            } else {

                self.loading = false
                self.showAlert = true

            }

        }.store(in: &cancellableSet)


    }

    func createAlert(with error: NetworkError) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }

}
