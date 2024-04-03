//
//  SplashUIView.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import SwiftUI

struct SplashPage: View {

    @State private var navigateToHome = false

    var body: some View {

        NavigationView {

            ZStack {

                VStack {

                    Spacer()

                    Image("splash")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 25)

                    Spacer()

                    BlurView(text: "HAZNEDAR", startTime: 0.0)
                }

                NavigationLink(destination: TabbarUIView(),
                    isActive: $navigateToHome) {
                }
            }
                .onAppear {

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {

                    navigateToHome = true
                }
            }
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
    }
}

struct SplashPage_Previews: PreviewProvider {
    static var previews: some View {
        SplashPage()
    }
}
