//
//  Service.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import Alamofire
import Combine
import Foundation

protocol ServiceProtocol {

    func fetchCryptoMarketList(
        currency: Currencies
    ) -> AnyPublisher<DataResponse<CryptoMarketList, NetworkError>, Never>

    func fetchLastNews(
        language: Languages
    ) -> AnyPublisher<DataResponse<NewsModel, NetworkError>, Never>

    func fetchCryptoDetail(
        id: String
    ) -> AnyPublisher<DataResponse<CryptoDetailModel, NetworkError>, Never>

    func fetchCustomCryptoMarketList(
        ids: String,
        currency: Currencies
    ) -> AnyPublisher<DataResponse<CustomCryptoMarketModel, NetworkError>, Never>
}

final class Service {
    static let shared = Service()
}

extension Service: ServiceProtocol {

    func fetchCryptoMarketList(
        currency: Currencies
    ) -> AnyPublisher<Alamofire.DataResponse<CryptoMarketList, NetworkError>, Never> {

        let url = URL(string: CryptoEndPoints.fetchAllList.url)!

        let parameters: Parameters = [
            "vs_currency": currency
        ]

        let session = CryptoNetworkManager.getManager()

        return session.request(url,
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

    func fetchLastNews(language: Languages) -> AnyPublisher<Alamofire.DataResponse<NewsModel, NetworkError>, Never> {

        let url = URL(string: NewsEndPoints.fetchAllNews.url)!

        let parameters: Parameters = [
            "Apikey": NewsEndPoints.fetchAllNews.apiKey,
            "lang": language
        ]

        return AF.request(url,
            method: .get,
            parameters: parameters
        )
            .validate()
            .publishDecodable(type: NewsModel.self)
            .map { response in
            response.mapError { error in
                let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0) }
                return NetworkError(initialError: error, backendError: backendError)
            }
        }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetchCryptoDetail(
        id: String
    ) -> AnyPublisher<Alamofire.DataResponse<CryptoDetailModel, NetworkError>, Never> {

        let url = URL(string: CryptoEndPoints.fetchCryptoDetail.url + id)!

        let session = CryptoNetworkManager.getManager()

        return session.request(url,
            method: .get
        )
            .validate()
            .publishDecodable(type: CryptoDetailModel.self)
            .map { response in
            response.mapError { error in
                let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0) }
                return NetworkError(initialError: error, backendError: backendError)
            }
        }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetchCustomCryptoMarketList(
        ids: String, currency: Currencies
    ) -> AnyPublisher<Alamofire.DataResponse<CustomCryptoMarketModel, NetworkError>, Never> {

        let url = URL(string: CryptoEndPoints.fetchCustomList.url)!

        let parameters: Parameters = [
            "ids": ids,
            "vs_currency": currency
        ]

        let session = CryptoNetworkManager.getManager()

        return session.request(url,
            method: .get,
            parameters: parameters
        )
            .validate()
            .publishDecodable(type: CustomCryptoMarketModel.self)
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
