//
//  CryptoEndPoints.swift
//  CryptoVault
//
//  Created by Cuma on 30/05/2023.
//

import Foundation

enum CryptoEndPoints: CryptoEndPointProtocol {

    case fetchAllList
    case fetchCryptoDetail
    case fetchCustomList

    var baseUrl: String {
        return "https://api.coingecko.com/"
    }

    var path: String {

        return "api/v3/"
    }

    var serviceUrl: String {

        switch self {

        case .fetchAllList:
            return "coins/markets"

        case .fetchCryptoDetail:
            return "coins/"

        case .fetchCustomList:
            return "coins/markets"
        }
    }
}
