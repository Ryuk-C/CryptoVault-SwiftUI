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

    @State var searchCryptoCurrency = ""
    @State var selectedCryptoId = ""
    @State var selectedCryptoName = ""
    @State var selectedCryptoPrice = ""
    @State private var navigateToDetail = false

    @StateObject private var viewModel = SavedCryptoViewModel()

    var body: some View {

        ZStack {

            Color("backgroundcolor").ignoresSafeArea()

            VStack {

                if viewModel.loading {

                    ScrollView {

                        LazyVStack {

                            ForEach((1...15).reversed(), id: \.self) { _ in

                                CryptoListView(name: "Terra Luna Classic", symbol: "LUNA",
                                    image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
                                    price: "2.974,25", priceChange: "0.49%"
                                )
                                    .redactShimmer(condition: viewModel.loading)
                            }
                        }
                            .padding(.bottom, 10)
                    }
                }

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

                        LazyVStack {

                            ForEach(viewModel.cryptoList, id: \.id) { list in

                                CryptoListView(name: list.name!, symbol: (list.symbol?.uppercased())!,
                                    image: list.image!, price: String(list.currentPrice),
                                    priceChange: String(list.priceChangePercentage24H!)
                                ).onTapGesture {

                                    selectedCryptoId = list.id!
                                    selectedCryptoName = list.name!
                                    selectedCryptoPrice = String(list.currentPrice)
                                    navigateToDetail.toggle()
                                }
                            }
                        }
                            .padding(.bottom, 10)
                    }
                        .padding(.top, 15)
                }
            }

            NavigationLink(
                destination: CryptoDetailPage(id: selectedCryptoId, name: selectedCryptoName, price: selectedCryptoPrice)
                    .navigationBarTitle("", displayMode: .inline)
                , isActive: $navigateToDetail) {
            }

                .onAppear {

                viewModel.getFavNews()
            }
        }
    }
}

struct SavedCryptoPage_Previews: PreviewProvider {
    static var previews: some View {
        SavedCryptoPage()
    }
}
