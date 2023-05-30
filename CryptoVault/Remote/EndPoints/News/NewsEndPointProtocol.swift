//
//  NewsEndPointProtocol.swift
//  CryptoVault
//
//  Created by Cuma on 30/05/2023.
//

import Foundation

protocol NewsEndPointProtocol {
    
    var baseUrl: String { get }
    var path: String { get }
    var serviceUrl: String { get }
    var apiKey: String { get }
}

extension NewsEndPointProtocol {
    
    var url: String {
        
        return baseUrl + path + serviceUrl
    }
}
