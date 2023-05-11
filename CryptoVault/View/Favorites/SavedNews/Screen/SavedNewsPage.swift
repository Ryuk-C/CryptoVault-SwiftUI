//
//  SavedNewsPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 28/04/2023.
//

import Kingfisher
import SwiftUI
import WaterfallGrid

struct SavedNewsPage: View {

    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var screenHeight: Double = UIScreen.main.bounds.height

    @StateObject private var viewModel = SavedNewsViewModel()

    var tabBar: UITabBar!

    @State private var goDetail = false
    @State private var id: String = ""
    @State private var newsUrl: String = ""
    @State private var newsSource: String = ""
    @State private var newsTitle: String = ""
    @State private var newsImageUrl: String = ""
    @State private var newsPublishedAt: String = ""

    var body: some View {

        VStack {

            if viewModel.favNews.isEmpty {

                LottieView(lottieFile: "anim_empty_crypto_list", speed: 0.9, play: true, loop: true)
                    .padding(.horizontal, 25)
                    .frame(height: screenHeight * 0.3)

                Text("There isn't any news in your reading list.")
                    .font(.system(size: 23, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.top, 25)
            } else {

                ScrollView {

                    WaterfallGrid(viewModel.favNews, id: \.self) { news in

                        FavNewsCardView(title: news.title ?? "", imageUrl: news.imageUrl ?? "",
                            source: news.source ?? "", dateOfNews: news.date ?? "")
                            .onTapGesture {

                            id = news.id ?? ""
                            newsUrl = news.newsUrl ?? "www.google.com"
                            newsSource = news.source!
                            newsTitle = news.title!
                            newsImageUrl = news.imageUrl ?? ""
                            newsPublishedAt = news.date!

                            goDetail.toggle()
                        }
                    }
                        .gridStyle(columns: 2, spacing: 10, animation: .easeInOut(duration: 0.5))
                        .padding([.top, .bottom], 15)
                        .padding([.trailing, .leading], 5)
                }
            }

            NavigationLink(
                destination: NewsDetailsPage(id: id, url: newsUrl,
                    source: newsSource ?? "News", title: newsTitle ?? "",
                    urlToImage: newsImageUrl ?? "", publishedAt: newsPublishedAt ?? ""
                )

                    .onAppear { self.tabBar.isHidden = true }
                    .navigationBarTitle("", displayMode: .inline)
                , isActive: $goDetail) {
            }
        }
            .onAppear {

            viewModel.getFavNews()

            guard let tabBar = tabBar else { return }
            tabBar.isHidden = false
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

struct SavedNewsPage_Previews: PreviewProvider {
    static var previews: some View {
        SavedNewsPage()
    }
}
