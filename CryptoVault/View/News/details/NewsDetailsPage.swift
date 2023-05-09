//
//  NewsDetailsPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 24/04/2023.
//

import SwiftUI

struct NewsDetailsPage: View {

    var id: String = ""
    var url: String = ""
    var source: String = ""
    var title: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""

    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var screenHeight: Double = UIScreen.main.bounds.height

    @ObservedObject private var viewModel = NewsDetailsViewModel()

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext

    var backButton: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
            HStack(spacing: 0) {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)

                Text("Back")
                    .font(.system(size: 17, weight: .semibold, design:
                        .rounded))
                    .foregroundColor(Color.white)
                    .padding(.leading, 5)

            }
        }
    }

    var body: some View {

        NavigationView() {

            VStack(spacing: 0) {

                ZStack(alignment: .bottom) {

                    VStack(spacing: 0) {

                        WebView(url: URL(string: url)!)
                            .frame(alignment: .top)

                        Spacer()

                    }

                    Color.white
                        .ignoresSafeArea()
                        .frame(width: screenWidth, height: screenHeight * 0.045)
                        .overlay(

                        VStack {

                            Divider()

                            Spacer()

                            HStack(alignment: .lastTextBaseline) {

                                Spacer()

                                Spacer()

                                HStack {

                                    Button(action: {

                                        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)

                                        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)


                                    }) {
                                        HStack(spacing: 0) {
                                            Image(systemName: "square.and.arrow.up")
                                                .font(.system(size: 21))
                                                .aspectRatio(contentMode: .fill)
                                                .foregroundColor(.black)
                                        }
                                    }.padding(.trailing, 20)

                                    Button(action: {

                                        let values = NewsCoreDataModel(id: id, newsUrl: url, title: title, imageUrl: urlToImage, source: source, date: publishedAt)

                                        viewModel.addNews(news: values)
                                        viewModel.toggleFavButton()

                                    }) {
                                        HStack(spacing: 0) {
                                            Image(systemName: viewModel.favButtonImageName)
                                                .font(.system(size: 21))
                                                .aspectRatio(contentMode: .fill)
                                                .foregroundColor(.black)
                                        }
                                    }

                                }
                                    .padding(.trailing, 25)

                            }


                        }

                        , alignment: .bottom
                    )
                        .padding(.bottom, 55)

                }

            }
                .onAppear {

                let values = NewsCoreDataModel(id: id, newsUrl: url, title: title, imageUrl: urlToImage, source: source, date: publishedAt)

                viewModel.setFavButtonImage(news: values)

            }
                .frame(width: screenWidth, height: screenHeight)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: backButton)

                .onBackSwipe {

                presentationMode.wrappedValue.dismiss()

            }
                .toolbar {
                ToolbarItem(placement: .principal) {

                    HStack {
                        Text(source)
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
            }



        }
            .colorScheme(.light)
            .navigationViewStyle(StackNavigationViewStyle()) .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")

    }


}

struct NewsDetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailsPage(id: "", url: "https://onmyway133.com/posts/how-to-make-bottom-sheet-in-swiftui/", source: "Binance", title: "", urlToImage: "", publishedAt: "")
    }
}
