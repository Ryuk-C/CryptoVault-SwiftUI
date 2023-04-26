//
//  Certificates.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 26/04/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Certificates {
    
    static let coingeckoCertificate: SecCertificate = Certificates.certificate(filename: "coingecko")

    private static func certificate(filename: String) -> SecCertificate {
        
        let filePath = Bundle.main.path(forResource: filename, ofType: "cer")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let certificate = SecCertificateCreateWithData(nil, data as CFData)!
        
        return certificate
  }
}
