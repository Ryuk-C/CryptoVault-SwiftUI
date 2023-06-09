//
//  HomeUIView.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import Kingfisher
import SwiftUI

struct HomePage: View {

    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var screenHeight: Double = UIScreen.main.bounds.height

    @State var searchCryptoCurrency = ""
    @State var selectedCryptoId = ""
    @State var selectedCryptoName = ""
    @State var selectedCryptoPrice = ""
    @State private var navigateToDetail = false
    @State var filterBottomSheet = false

    @State private var tabBar: UITabBar! = nil

    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {

        NavigationView {

            ZStack(alignment: .top) {

                Color("backgroundcolor").ignoresSafeArea()

                VStack(alignment: .leading) {

                    HStack {

                        HStack {

                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray.opacity(0.5))

                            TextField("Search Coin", text: $searchCryptoCurrency)
                                .foregroundColor(Color.black)
                        }
                            .padding()
                            .cornerRadius(10)
                    }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray.opacity(0.60), lineWidth: 0.75)
                            .background(.white)
                            .cornerRadius(10)
                    )
                        .padding(.horizontal, 10)
                        .padding(.top, 15)

                    Text("All coins")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.black.opacity(0.75))
                        .padding(.top, 15)
                        .padding(.leading, 20)

                    if viewModel.success == "OK" {

                        RefreshableScrollView {

                            LazyVStack {

                                ForEach(viewModel.cryptoList.filter { crypto in /// filter

                                    searchCryptoCurrency.isEmpty ||
                                        crypto.name.localizedStandardContains(searchCryptoCurrency) ||
                                        crypto.symbol.localizedStandardContains(searchCryptoCurrency)
                                }, id: \.id
                                ) { list in

                                    CryptoListView(name: list.name, symbol: list.symbol.uppercased(),
                                        image: list.image, price: String(list.currentPrice),
                                        priceChange: String(list.priceChangePercentage24H)
                                    ).onTapGesture {

                                        selectedCryptoId = list.id
                                        selectedCryptoName = list.name
                                        selectedCryptoPrice = String(list.currentPrice)
                                        navigateToDetail.toggle()
                                    }
                                }
                            }
                                .padding(.bottom, 10)
                        } onRefresh: {

                            viewModel.fetchCryptoList(currency: Currencies.USD)
                        }
                    }

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
                }

                NavigationLink(
                    destination: CryptoDetailPage(id: selectedCryptoId, name: selectedCryptoName, price: selectedCryptoPrice)
                        .navigationBarTitle("", displayMode: .inline)
                    , isActive: $navigateToDetail) {
                }
            }
                .onAppear {

                viewModel.fetchCryptoList(currency: Currencies.USD)

                guard let tabBar = tabBar else { return }
                tabBar.isHidden = false
            }
                .alert(
                    viewModel.message, isPresented: $viewModel.showAlert)
            {
                Button("OK", role: .cancel) { }
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Home")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                            .foregroundColor(Color.white)
                    }
                }
            }
                .navigationBarBackButtonHidden(true)

        }
        .colorScheme(.light)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .onAppear {

            UINavigationBarAppearance()
                .setColor(title: .white, background: .mainColor)
        }
            .background(
            TabBarAccessor
            { tabbar in
                self.tabBar = tabbar
            }
        )
    }
}

struct CryptoListView: View {

    var name = "Bitcoin"
    var symbol = "BTC"
    var image = ""
    var price = "27.345"
    var priceChange = "0.58"
    var body: some View {

        HStack {

            KFImage(URL(string: image))
                .resizable()
                .cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                .clipped()
                .frame(width: 40, height: 40)
                .padding(.vertical, 10)
                .padding(.leading, 10)

            VStack(alignment: .leading, spacing: 0) {

                Text(name)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.black)

                Text(symbol)
                    .font(.system(size: 14, weight: .semibold, design: .monospaced))
                    .foregroundColor(.black.opacity(0.6))
            }.padding(.leading, 5)

            Spacer()

            VStack(alignment: .trailing, spacing: 0) {

                Text("$" + price)
                    .font(.system(size: 16, weight: .bold, design: .rounded))

                if priceChange.first == "-" {

                    Text(priceChange + "%")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(.red)
                        .padding(.top, 2)
                } else {

                    Text(priceChange + "%")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(.green)
                        .padding(.top, 2)
                }
            }.padding(.trailing, 10)
        }.background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray.opacity(0.60), lineWidth: 0.75)
                .background(.white)
                .cornerRadius(10)
        )
            .padding([.horizontal], 10)
    }

    }

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
