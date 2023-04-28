//
//  FavoritesPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import SwiftUI
import WaterfallGrid
import Kingfisher

struct FavoritesPage: View {

    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var screenHeight: Double = UIScreen.main.bounds.height
    @State private var selectedTab: Int = 0

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
                                        SavedNewsPage()
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

        }
    }

}

struct FavoritesPage_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesPage()
    }
}
