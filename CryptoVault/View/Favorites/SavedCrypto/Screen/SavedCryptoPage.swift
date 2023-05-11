//
//  SavedCryptoPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 28/04/2023.
//

import SwiftUI

struct SavedCryptoPage: View {

    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var screenHeight: Double = UIScreen.main.bounds.height

    @StateObject private var viewModel = SavedCryptoViewModel()

    var body: some View {
        
        VStack {

            if viewModel.favCrypto.isEmpty {

                LottieView(lottieFile: "anim_empty_crypto_list", speed: 0.9, play: true, loop: true)
                    .padding(.horizontal, 25)
                    .frame(height: screenHeight * 0.3)

                Text("There isn't any currency in your reading list.")
                    .font(.system(size: 23, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.top, 25)

            } else {

                ScrollView {



                }
            }
        }
        .onAppear {

            viewModel.getFavNews()
        }
    }
}

struct SavedCryptoPage_Previews: PreviewProvider {
    static var previews: some View {
        SavedCryptoPage()
    }
}
