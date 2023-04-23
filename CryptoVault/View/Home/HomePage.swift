//
//  HomeUIView.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import SwiftUI

struct HomePage: View {
    
    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var screenHeight: Double = UIScreen.main.bounds.height
    
    @State var searchCryptoCurrency = ""
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        
        NavigationView {
            
            
            ZStack {
                
                Color("backgroundcolor")
                
                VStack {
                
                    HStack {

                        HStack {

                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray.opacity(0.5))

                            TextField("Search Coin", text: $searchCryptoCurrency)
                                .foregroundColor(Color.black)
                        }
                            .padding()
                            .cornerRadius(10)

                    } .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray.opacity(0.60), lineWidth: 0.75)
                            .background(.white)
                            .cornerRadius(10)
                    )
                        .padding(.horizontal, 10)
                        .padding(.top, 20)
                    
                    
                    Spacer()
                    
                    Spacer()
                    
                }
                
            }
            .onAppear{
                
                print(viewModel.cryptoList)
                
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
                    .navigationViewStyle(StackNavigationViewStyle()) .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle("")
            .onAppear {

                       UINavigationBarAppearance()
                    .setColor(title: .white, background: .mainColor)

                   }
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
