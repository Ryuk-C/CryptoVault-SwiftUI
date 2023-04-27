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
    @State private var favoriteType = 0

    @StateObject private var viewModel = FavoriteViewModel()

    var body: some View {

        NavigationView {
            
            VStack {
                
                Picker("What is your favorite color?", selection: $favoriteType) {
                    Text("Crypto").tag(0)
                    Text("News").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                if viewModel.favNews.isEmpty {
                    
                    LottieView(lottieFile: "anim_empty", speed: 1, play: true, loop: false)
                        .padding(.horizontal, 25)
                    
                } else {
                    
                ScrollView {

                    WaterfallGrid(viewModel.favNews, id: \.self) { news in
                        
                        FavNewsCardView(title: news.title ?? "", imageUrl: news.imageUrl ?? "", source: news.source ?? "", dateOfNews: news.date ?? "")

                    }
                        .gridStyle(columns: 2, spacing: 10, animation: .easeInOut(duration: 0.5))
                        .padding([.top, .bottom], 15)
                        .padding([.trailing, .leading], 5)

                }

                }

            }
                .onAppear {
                viewModel.getFavNews()
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

            }

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

struct FavNewsCardView: View {

    var title: String
    var imageUrl: String
    var source: String
    var dateOfNews: String

    var body: some View {

        VStack(alignment: .center, spacing: 0) {

            KFImage(URL(string: imageUrl))
                .forceRefresh()
                .resizable()
                .cornerRadius(10, corners: [.topLeft, .topRight])
                .clipped()
                .frame(width: UIScreen.main.bounds.width / 2 - 10, height: 140)

            Divider()

            Text(source)
                .foregroundColor(.black.opacity(0.5))
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.top, 10)
                .padding([.leading, .trailing], 5)

            Text(title)
                .foregroundColor(.black.opacity(0.8))
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.top, 12)
                .padding([.leading, .trailing], 5)

            Text(dateOfNews)
                .foregroundColor(.black.opacity(0.6))
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding([.top, .bottom], 12)
                .padding([.leading, .trailing], 5)

        }
            .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.white)
        )
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 0.75)
        )
    }

}


struct FavoritesPage_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesPage()
    }
}
