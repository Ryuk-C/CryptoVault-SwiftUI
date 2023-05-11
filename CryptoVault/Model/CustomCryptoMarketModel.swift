//
//  CustomCryptoMarketModel.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 10/05/2023.
//

import Foundation

// MARK: - CustomCryptoMarketModel
struct CustomCryptoMarketModelElement: Codable {
    let id, symbol, name: String?
    let image: String?
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Int?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
    }
}

typealias CustomCryptoMarketModel = [CustomCryptoMarketModelElement]
