//
//  CryptoEndPointProtocol.swift
//  CryptoVault
//
//  Created by Cuma on 30/05/2023.
//

import Foundation

protocol CryptoEndPointProtocol {
    
    var baseUrl: String { get }
    var path: String { get }
    var serviceUrl: String { get }
}

extension CryptoEndPointProtocol {
    
    var url: String {
        return baseUrl + path + serviceUrl
    }
}
