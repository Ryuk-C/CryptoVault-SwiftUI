//
//  FavoriteTabs.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 28/04/2023.
//

import SwiftUI

struct Tab {
    var icon: Image?
    var title: String
}
struct Tabs: View {
    var fixed = true
    var tabs: [Tab]
    var geoWidth: CGFloat
    @Binding var selectedTab: Int
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< tabs.count, id: \.self) { row in
                            Button(action: {
                                withAnimation {
                                    selectedTab = row
                                }
                            }, label: {
                                    VStack(spacing: 0) {
                                        HStack {
                                            // Image
                                            AnyView(tabs[row].icon)
                                                .foregroundColor(.white)
                                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                                            // Text
                                            Text(tabs[row].title)
                                                .font(Font.system(size: 18, weight: .semibold))
                                                .foregroundColor(Color.white)
                                                .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
                                        }
                                            .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
                                        // Bar Indicator
                                        Rectangle().fill(selectedTab == row ? Color.yellow : Color.clear)
                                            .frame(height: 4)
                                    }.fixedSize()
                                })
                                .accentColor(Color("maincolor"))
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                        .onChange(of: selectedTab) { target in
                        withAnimation {
                            proxy.scrollTo(target)
                        }
                    }
                }
            }
        }.background(Color("maincolor"))
            .frame(height: 55)
            .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
    }
}
struct Tabs_Previews: PreviewProvider {
    static var previews: some View {

        Tabs(fixed: true,
            tabs: [.init(icon: Image(systemName: "bitcoinsign.circle.fill"), title: "Crypto"),
                    .init(icon: Image(systemName: "newspaper.fill"), title: "News")],
            geoWidth: 375,
            selectedTab: .constant(0))
    }
}
