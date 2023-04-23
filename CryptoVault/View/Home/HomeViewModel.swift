//
//  HomeViewModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 23/04/2023.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var message: String = ""
    @Published var cryptoList = [CryptoMarketList]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol

    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
        fetchCryptoList()
        
    }
    
    func fetchCryptoList() {
        
        loading = false
        showAlert = false
        
        dataManager.fetchCryptoMarketList(currency: Currencies.USD)
            .sink{(dataResponse) in
                
                
                if dataResponse.error == nil {
                    
                    self.cryptoList = [dataResponse.value!]
                    self.loading = false
                    self.showAlert = false
                    
                }else {
                    
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
