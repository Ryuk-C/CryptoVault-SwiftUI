//
//  Extensions.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import Foundation
import SwiftUI

extension UIColor {
    
    class var mainColor: UIColor {
        return UIColor(named: "maincolor")!
    }
    
}

extension UINavigationBarAppearance {

    func setColor(title: UIColor? = nil, background: UIColor? = nil) {
        configureWithTransparentBackground()

        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "Georgia-Bold", size: 35)!]

        if let titleColor = title {
            largeTitleTextAttributes = [.foregroundColor: titleColor]
            titleTextAttributes = [.foregroundColor: titleColor]
        }
        backgroundColor = background
        UINavigationBar.appearance().scrollEdgeAppearance = self
        UINavigationBar.appearance().standardAppearance = self

    }

}
