//
//  SavedCryptoPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 28/04/2023.
//

import SwiftUI

struct SavedCryptoPage: View {

    @StateObject private var viewModel = SavedCryptoViewModel()

    var body: some View {
        
        VStack {

            if viewModel.favCrypto.isEmpty {

                LottieView(lottieFile: "anim_empty", speed: 1, play: true, loop: false)
                    .padding(.horizontal, 25)
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
