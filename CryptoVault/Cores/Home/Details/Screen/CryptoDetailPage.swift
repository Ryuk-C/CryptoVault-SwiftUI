//
//  CryptoDetailPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 10/05/2023.
//

import Kingfisher
import SwiftUI

struct CryptoDetailPage: View {

    var id = "bitcoin"
    var name = ""
    var price = ""
    @State var cryptoHomePage = ""

    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var screenHeight: Double = UIScreen.main.bounds.height

    @ObservedObject private var viewModel = CryptoDetailViewModel()
    @State private var tabBar: UITabBar! = nil

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext

    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 0) {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)

                Text("Back")
                    .font(.system(size: 17, weight: .semibold, design:
                        .rounded))
                    .foregroundColor(Color.white)
                    .padding(.leading, 5)
            }
        }
    }

    var favoriteButton: some View {

        Button(action: {

            let values = CryptoCoreDataModel(id: id, name: name, price: price)

            viewModel.addCrypto(crypto: values)
            viewModel.toggleFavButton()

        }) {
            HStack(spacing: 0) {
                Image(systemName: viewModel.favButtonImageName)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.yellow)
            }
        }
    }

    var body: some View {

        NavigationView {

            ZStack(alignment: .center) {

                Color("backgroundcolor").ignoresSafeArea()

                if viewModel.cryptoSaved {

                    LottieView(lottieFile: "anim_star", speed: 1.3, play: true, loop: false)
                        .frame(width: 225, height: 225)

                }

                VStack {

                    if viewModel.success == "OK" {

                        ForEach(viewModel.cryptoDetailList, id: \.id) { crypto in

                            VStack {

                                List {

                                    Section {

                                        HStack(spacing: 0) {

                                            KFImage(URL(string: crypto.image?.large ?? ""))
                                                .resizable()
                                                .cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                                                .clipped()
                                                .frame(width: 70, height: 70)
                                                .padding(.leading, 10)
                                                .padding(.vertical, 5)

                                            VStack {


                                                VStack(alignment: .leading, spacing: 0) {

                                                    Text(crypto.name ?? "")
                                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                                        .foregroundColor(.black)

                                                    Text(crypto.symbol!.uppercased() )
                                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                                        .foregroundColor(.black.opacity(0.7))
                                                }.padding(.leading, 5)

                                            }.padding(.leading, 10)

                                            Spacer()

                                            VStack(spacing: 0) {

                                                Image(systemName: "flag.2.crossed.fill")
                                                    .resizable()
                                                    .foregroundColor(.yellow)
                                                    .frame(width: 45, height: 25, alignment: .center)


                                                Text("#" + String(crypto.marketCapRank!))
                                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                                    .foregroundColor(.yellow)
                                                    .padding(.top, 5)

                                            }.padding(.trailing, 15)



                                        }.padding(.vertical, 10)

                                    }.listRowInsets(EdgeInsets())


                                    Section {

                                        VStack {

                                            HStack {

                                                Text("USD")
                                                    .font(.system(size: 15, weight: .medium, design: .rounded))

                                                Spacer()

                                                Text(String(viewModel.usdPrice) + "$")
                                                    .font(.system(size: 15, weight: .medium, design: .rounded))


                                            }

                                            Divider()

                                            HStack {

                                                Text("EUR")
                                                    .font(.system(size: 15, weight: .medium, design: .rounded))

                                                Spacer()

                                                Text(String(viewModel.eurPrice) + "€")
                                                    .font(.system(size: 15, weight: .medium, design: .rounded))


                                            }

                                            Divider()

                                            HStack {

                                                Text("TRY")
                                                    .font(.system(size: 15, weight: .medium, design: .rounded))

                                                Spacer()

                                                Text(String(viewModel.tryliraPrice) + "₺")
                                                    .font(.system(size: 15, weight: .medium, design: .rounded))


                                            }

                                        }


                                    } header: {
                                        Text("Current Price")
                                            .textCase(nil)


                                    }

                                    Section {

                                        VStack {

                                            HStack {

                                                Text("USD")
                                                    .font(.system(size: 15, weight: .medium, design: .rounded))

                                                Spacer()

                                                if viewModel.usdPriceChange.first == "-" {

                                                    Text(String(viewModel.usdPriceChange) + "%")
                                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                                        .foregroundColor(.red)
                                                        .padding(.top, 2)
                                                } else {

                                                    Text(String(viewModel.usdPriceChange) + "%")
                                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                                        .foregroundColor(.green)
                                                        .padding(.top, 2)
                                                }

                                            }

                                            Divider()

                                            HStack {
                                                

                                                Text("EUR")
                                                    .font(.system(size: 15, weight: .medium, design: .rounded))

                                                Spacer()

                                                if viewModel.eurPriceChange.first == "-" {

                                                    Text(String(viewModel.eurPriceChange) + "%")
                                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                                        .foregroundColor(.red)
                                                        .padding(.top, 2)
                                                } else {

                                                    Text(String(viewModel.eurPriceChange) + "%")
                                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                                        .foregroundColor(.green)
                                                        .padding(.top, 2)
                                                }

                                            }

                                            Divider()

                                            HStack {

                                                Text("TRY")
                                                    .font(.system(size: 15, weight: .medium, design: .rounded))

                                                Spacer()

                                                if viewModel.eurPriceChange.first == "-" {

                                                    Text(String(viewModel.tryPriceChange) + "%")
                                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                                        .foregroundColor(.red)
                                                        .padding(.top, 2)
                                                } else {

                                                    Text(String(viewModel.tryPriceChange) + "%")
                                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                                        .foregroundColor(.green)
                                                        .padding(.top, 2)
                                                }

                                            }

                                        }


                                    } header: {
                                        Text("Price Change")
                                            .textCase(nil)
                                    }

                                    Section {

                                        VStack {

                                            Text(crypto.description?.en ?? "")

                                        }



                                    } header: {

                                        Text("Description")
                                            .textCase(nil)
                                    }

                                }


                            }
                    }



                    }

                    Spacer()

                    Spacer()

                }
                    .onAppear {

                    viewModel.fetchCryptoList(id: id)

                    let values = CryptoCoreDataModel(id: id, name: name, price: price)

                    viewModel.setFavButtonImage(crypto: values)

                        guard let tabBar = tabBar else { return }
                        tabBar.isHidden = true
                        
                }
                    .alert(viewModel.message, isPresented: $viewModel.showAlert) {
                    Button("OK", role: .cancel) { }
                }

            }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: backButton, trailing: favoriteButton)
                .onBackSwipe {

                presentationMode.wrappedValue.dismiss()
            }
                .toolbar {
                ToolbarItem(placement: .principal) {

                    HStack {
                        Text(name)
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
            }

        } .colorScheme(.light)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .background(TabBarAccessor { tabbar in
            self.tabBar = tabbar
        }
        )
    }
}

struct CryptoDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailPage()
    }
}
