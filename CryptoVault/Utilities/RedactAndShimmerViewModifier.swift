//
//  RedactAndShimmerViewModifier.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 24/04/2023.
//

import SwiftUI
import Foundation

public struct RedactAndShimmerViewModifier: ViewModifier {
  private let condition: Bool
  
  init(condition: Bool) {
    self.condition = condition
  }
  
  public func body(content: Content) -> some View {
    if condition {
      content
        .redacted(reason: .placeholder)
        .shimmering()
    } else {
     content
    }
  }
}


extension View {
  public func redactShimmer(condition: Bool) -> some View {
    modifier(RedactAndShimmerViewModifier(condition: condition))
  }
}
