//
//  SettingsPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import SwiftUI

struct InfoPage: View {
    var body: some View {

        NavigationView {
            
            VStack {
                
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                                
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Info")
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

struct InfoPage_Previews: PreviewProvider {
    static var previews: some View {
        InfoPage()
    }
}
