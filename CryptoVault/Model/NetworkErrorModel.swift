//
//  NetworkErrorModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import Foundation
import Alamofire

struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
