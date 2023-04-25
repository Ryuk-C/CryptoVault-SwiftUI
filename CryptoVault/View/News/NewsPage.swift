//
//  NewsPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import SwiftUI
import Kingfisher
import WaterfallGrid

struct NewsPage: View {

    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var screenHeight: Double = UIScreen.main.bounds.height

    @State private var goDetail: Bool = false
    @State private var newsUrl: String = ""
    @State private var newsSource: String? = ""
    @State private var newsTitle: String? = ""
    @State private var newsImageUrl: String? = ""
    @State private var newsPublishedAt: String? = ""

    @ObservedObject var viewModel = NewsViewModel()

    var body: some View {

        NavigationView {

            ZStack {

                Color("backgroundcolor").ignoresSafeArea()

                VStack {

                    if viewModel.success == 100 {

                        ScrollView {

                            WaterfallGrid(viewModel.newsList, id: \.url) { news in

                                NewsCardVerticalView(title: news.title, imageUrl: news.imageurl, source: news.sourceInfo.name, dateOfNews: String(news.publishedOn))
                                    .onTapGesture {

                                    newsUrl = news.url
                                    newsSource = news.sourceInfo.name
                                    newsTitle = news.title
                                    newsImageUrl = news.imageurl
                                    newsPublishedAt = String(news.publishedOn)

                                    goDetail.toggle()

                                }

                            }
                                .gridStyle(columns: 2, spacing: 10, animation: .easeInOut(duration: 0.5))
                                .padding([.top, .bottom], 15)
                                .padding([.trailing, .leading], 5)
                                .redactShimmer(condition: viewModel.loading)

                        }

                    }
                    
                    if viewModel.loading {

                        ScrollView {

                            WaterfallGrid((1...15).reversed(), id: \.self) { news in

                                NewsCardVerticalView(title: "They have not explained how members of the public got hold of the suspects.", imageUrl: "news.imageurl", source: "BBC News", dateOfNews: "12.09.2023")
                            }
                                .gridStyle(columns: 2, spacing: 10, animation: .easeInOut(duration: 0.5))
                                .padding([.top, .bottom], 15)
                                .padding([.trailing, .leading], 5)
                                .redactShimmer(condition: viewModel.loading)

                        }

                    }


                }
                    

            }.onAppear {
                viewModel.fetchNewsList(language: Languages.EN)
            }
            .alert(viewModel.message, isPresented: $viewModel.showAlert) {
                        Button("OK", role: .cancel) { }
                    }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("News")
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

struct NewsCardVerticalView: View {

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

struct NewsPage_Previews: PreviewProvider {
    static var previews: some View {
        NewsPage()
    }
}
