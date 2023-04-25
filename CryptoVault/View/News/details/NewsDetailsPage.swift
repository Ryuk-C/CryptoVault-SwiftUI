//
//  NewsDetailsPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 24/04/2023.
//

import SwiftUI

struct NewsDetailsPage: View {
    
    var url: String = ""
    var source: String = ""
    var title: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    
    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var screenHeight: Double = UIScreen.main.bounds.height

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showNewsOptions: Bool = false

    var backButton: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
            HStack(spacing: 0) {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.purple)
                
                Text("Back")
                    .font(.system(size: 17, weight: .semibold, design:
                        .rounded))
                    .foregroundColor(Color.purple)
                    .padding(.leading, 5)

            }
        }
    }

    var shareButton: some View { Button(action: {

        showNewsOptions.toggle()
        
    }) {
            HStack(spacing: 0) {
                Image(systemName: "text.alignleft")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.purple)
            }
        }
    }
    
    var body: some View {
        
        
        NavigationView() {
                
                VStack(spacing: 0){

                    ZStack{

                        VStack(spacing: 0) {

                            WebView(url: URL(string: url)!)
                                .frame(alignment: .top)
                            
                            Spacer()
                            
                            Color.white
                                .ignoresSafeArea()
                                .frame(width: screenWidth, height: screenHeight * 0.045)
                                .overlay(
                                    
                                    VStack{
                                        
                                        Divider()
                                        
                                        Spacer()
                                        
                                        HStack(alignment: .lastTextBaseline){
                                            
                                            Spacer()
                                            
                                            Spacer()
                                            
                                            HStack{
                                                
                                                Button(action: {
                                                    
                                                    

                                                }) {
                                                        HStack(spacing: 0) {
                                                            Image(systemName: "heart")
                                                                .font(.system(size: 19))
                                                                .aspectRatio(contentMode: .fill)
                                                                .foregroundColor(.black)
                                                        }
                                                    }.padding(.trailing, 20)
                                                
                                                Button(action: {
                                                    
                                                    let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)

                                                    UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)

                                                }) {
                                                        HStack(spacing: 0) {
                                                            Image(systemName: "square.and.arrow.up")
                                                                .font(.system(size: 19))
                                                                .aspectRatio(contentMode: .fill)
                                                                .foregroundColor(.black)
                                                        }
                                                }.padding(.trailing, 20)
                                                
                                                Button(action: {
                                                    
                                                   // vm.addSavedNewsData(url: url, title: title, urlToImage: urlToImage, source: source, publishedAt: publishedAt)

                                                }) {
                                                        HStack(spacing: 0) {
                                                            Image(systemName: "bookmark")
                                                                .font(.system(size: 19))
                                                                .aspectRatio(contentMode: .fill)
                                                                .foregroundColor(.black)
                                                        }
                                                    }
                                                
                                            }
                                            .padding(.trailing, 20)
                                            
                                        
                                            
                                        }

                                        
                                    }
                          
                                        , alignment: .bottom
                                )
                                .padding(.bottom, 55)
                        }
                        
                    }
                    
                }.frame(width: screenWidth, height: screenHeight)

                .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: backButton, trailing: shareButton)
                    .onBackSwipe {

                    presentationMode.wrappedValue.dismiss()

                }
                    .toolbar {
                    ToolbarItem(placement: .principal) {

                        HStack {
                            Text(source)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                                .foregroundColor(.purple)
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
        NewsDetailsPage(url: "https://onmyway133.com/posts/how-to-make-bottom-sheet-in-swiftui/", source: "", title: "", urlToImage: "", publishedAt: "")
    }
}
