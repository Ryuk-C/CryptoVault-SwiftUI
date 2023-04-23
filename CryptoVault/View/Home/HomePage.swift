//
//  HomeUIView.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import SwiftUI

struct HomePage: View {

    var body: some View {

        NavigationView {

            VStack {

                Text("")

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
