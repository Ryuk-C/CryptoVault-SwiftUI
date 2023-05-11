//
//  TabbarUIView.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import SwiftUI

struct TabbarUIView: View {

    @State private var tabSelection = 0

    var body: some View {

        NavigationView {

            TabView(selection: $tabSelection) {

                HomePage()
                    .tabItem {
                    Image(systemName: "square.stack.3d.up.fill")
                    Text("Home")
                    }
                    .tag(0)

                NewsPage()
                    .tabItem {
                    Image(systemName: "newspaper")
                    Text("News")
                    }
                    .tag(1)

                FavoritesPage()
                    .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Favorites")
                    }
                    .tag(2)

                InfoPage()
                    .tabItem {
                    Image(systemName: "info.circle.fill")
                    Text("Info")
                    }
                    .tag(3)
            }
                .accentColor(Color("maincolor"))

                .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                appearance.backgroundColor = UIColor(Color.white.opacity(1))

                // Use this appearance when scrolling behind the TabView:
                UITabBar.appearance().standardAppearance = appearance
                // Use this appearance when scrolled all the way up:
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }

                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
        }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
    }
}

struct TabbarUIView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarUIView()
    }
}
