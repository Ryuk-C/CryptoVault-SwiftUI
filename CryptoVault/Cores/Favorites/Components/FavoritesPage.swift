//
//  FavoritesPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import Kingfisher
import SwiftUI
import WaterfallGrid

struct FavoritesPage: View {

    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var screenHeight: Double = UIScreen.main.bounds.height
    @State private var selectedTab: Int = 0
    @State private var tabBar: UITabBar! = nil

    let tabs: [Tab] = [
            .init(icon: Image(systemName: "bitcoinsign.circle.fill"), title: "Crypto"),
            .init(icon: Image(systemName: "newspaper.fill"), title: "News")
    ]

    var body: some View {

        NavigationView {

            ZStack(alignment: .bottomTrailing) {

                VStack(spacing: 0) {

                    GeometryReader { geo in

                        ZStack {

                            VStack(spacing: 0) {

                                // Tabs
                                Tabs(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)
                                Divider()
                                    .frame(height: 5)

                                // Views
                                TabView(selection: $selectedTab,
                                    content: {
                                        SavedCryptoPage()
                                            .tag(0)
                                        SavedNewsPage(tabBar: tabBar)
                                            .tag(1)
                                    })
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            }
                        }
                    }
                }
            }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Favorites")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                            .foregroundColor(Color.white)
                    }
                }
            }
                .navigationBarBackButtonHidden(true)
                .onAppear {
                guard let tabBar = tabBar else { return }
                tabBar.isHidden = false
            }
        }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .background(TabBarAccessor { tabbar in // << here !!
                self.tabBar = tabbar
           }
           )
    }
}

struct FavoritesPage_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesPage()
    }
}
