//
//  NewsEndPoints.swift
//  CryptoVault
//
//  Created by Cuma on 30/05/2023.
//

import Foundation

enum NewsEndPoints: CryptoEndPointProtocol {

    case fetchAllNews

    var baseUrl: String {
        return "https://min-api.cryptocompare.com/"
    }

    var path: String {
        return "data/v2/"
    }
    
    var serviceUrl: String {

        switch self {

        case .fetchAllNews:
            return "news/"
        }
    }
    
    var apiKey: String {
         return "172f656d6f3196ea6bd6416cddc48c7bf17476b17f6f397755c9ee3fe250fbd6"
    }
}
