//
//  CryptoDetailPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 10/05/2023.
//

import SwiftUI

struct CryptoDetailPage: View {

    var id = ""
    var name = ""
    var price = ""
    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var screenHeight: Double = UIScreen.main.bounds.height

    @ObservedObject private var viewModel = CryptoDetailViewModel()

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext

    var backButton: some View { Button(action: {
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

    var favoriteButton: some View { Button(action: {

        let values = CryptoCoreDataModel(id: id, name: name , price: price)

        viewModel.addCrypto(crypto: values)
        viewModel.toggleFavButton()
        

    }) {
            HStack(spacing: 0) {
                Image(systemName: viewModel.favButtonImageName)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }

    var body: some View {

        NavigationView{

            VStack {

                Text("Hello, World!")

            }
            .onAppear {

                viewModel.fetchCryptoList(id: id)

                let values = CryptoCoreDataModel(id: id, name: name, price: price)

                viewModel.setFavButtonImage(crypto: values)
        }
            .alert(viewModel.message, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        }
            .frame(width: screenWidth, height: screenHeight)
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

    }
}

struct CryptoDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailPage()
    }
}
