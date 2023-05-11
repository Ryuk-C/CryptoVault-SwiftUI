//
//  LottieView.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {

    let lottieFile: String
    let speed: Double
    let play: Bool
    let loop: Bool

    let animationView = LottieAnimationView()

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)

        animationView.animation = Animation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = speed
        if play == true {
            animationView.play()
        }

        if loop == true {
            animationView.loopMode = .loop
        }
        view.addSubview(animationView)

        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.backgroundBehavior = .pauseAndRestore

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
