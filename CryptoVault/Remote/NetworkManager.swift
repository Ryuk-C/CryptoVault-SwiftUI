//
//  NetworkManager.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 26/04/2023.
//

import Alamofire
import Foundation

class CryptoPinning {

    var Manager: Session?

    init() {
        
        let trustEvaluator = [
            "api.coingecko.com": PinnedCertificatesTrustEvaluator(certificates: [Certificates.coingeckoCertificate])
        ]

        Manager = Session(serverTrustManager: ServerTrustManager(evaluators: trustEvaluator))
    }
}

class CryptoNetworkManager {
    
    private static let NetworkManager = CryptoPinning()

    public static func getManager() -> Session {
        return NetworkManager.Manager!
    }
 }
