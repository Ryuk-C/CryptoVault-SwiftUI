//
//  Service.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import Foundation
import Alamofire
import Combine

protocol ServiceProtocol {
    
    func fetchCryptoMarketList(currency: Currencies) -> AnyPublisher<DataResponse<CryptoMarketList, NetworkError>, Never>

}

class Service {
    
    static let shared = Service()
    
    private init() {}
    
}

extension Service : ServiceProtocol {
    
    func fetchCryptoMarketList(currency: Currencies) -> AnyPublisher<Alamofire.DataResponse<CryptoMarketList, NetworkError>, Never> {
        
        let url = URL(string: Constants.BASE_URL)!

        let parameters: Parameters = [
            "vs_currency": currency,
        ]

        return AF.request(url,
            method: .get,
            parameters: parameters
        )
            .validate()
            .publishDecodable(type: CryptoMarketList.self)
            .map { response in
            response.mapError { error in
                let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0) }
                return NetworkError(initialError: error, backendError: backendError)
            }
        }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    
    
}
