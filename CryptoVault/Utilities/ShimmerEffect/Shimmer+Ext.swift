//
//  Shimmer+Ext.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 10/05/2023.
//

import SwiftUI

extension View {
    public func redactShimmer(condition: Bool) -> some View {
        modifier(RedactAndShimmerViewModifier(condition: condition))
    }
}
