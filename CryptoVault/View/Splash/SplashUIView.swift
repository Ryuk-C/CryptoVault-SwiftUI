//
//  SplashUIView.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import SwiftUI

struct SplashPage: View {
    
    @State private var tabbar = false

    
    var body: some View {
        
        NavigationView{
            
            ZStack {

                VStack {

                    EmptyView()

                    LottieView(lottieFile: "anim_splashcrypto", speed: 1, play: true, loop: true)
                        .padding(.horizontal, 20)

                    Text("Haznedar")
                        .font(Font.custom("Library3amsoft", size: 30))
                        .foregroundColor(.white)


                }.background(Color("maincolor"))
                
                NavigationLink(destination: TabbarUIView()
                    , isActive: $tabbar) {

                }

            }
            .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

                    tabbar = true

                }

            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
        }.navigationViewStyle(StackNavigationViewStyle()) .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")

    }
    
}

struct SplashPage_Previews: PreviewProvider {
    static var previews: some View {
        SplashPage()
    }
}
