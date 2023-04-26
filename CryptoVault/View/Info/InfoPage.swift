//
//  SettingsPage.swift
//  CryptoVault
//
//  Created by Cuma Haznedar on 21/04/2023.
//

import SwiftUI

struct InfoPage: View {
    var body: some View {

        NavigationView {

            VStack {

                List {

                    Section {

                        HStack {

                            HStack {

                                Text("Github")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))

                                Spacer()
                                    .onTapGesture {

                                    withAnimation {


                                    }

                                }
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(.blue)
                                    .frame(
                                    alignment: .leading
                                )
                            }

                        }
                            .onTapGesture {

                            UIApplication.shared.open(URL(string: "https://github.com/Ryuk-C")!)

                        }

                        HStack {

                            HStack {

                                Text("LinkedIn")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))

                                Spacer()
                                    .onTapGesture {

                                    withAnimation {


                                    }

                                }
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(.blue)
                                    .frame(
                                    alignment: .leading
                                )
                            }

                        }
                            .onTapGesture {

                            UIApplication.shared.open(URL(string: "https://www.linkedin.com/in/cumahaznedar/")!)
                        }


                        HStack {

                            Text("Mail")
                                .font(.system(size: 15, weight: .medium, design: .rounded))

                            Spacer()
                                .onTapGesture {

                                withAnimation {


                                }

                            }
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.blue)
                                .frame(
                                alignment: .leading
                            )
                        }
                            .onTapGesture {

                            openMailApp(toEmail: "cumahaznedar@gmail.com", subject: "CryptoVault", body: "")
                        }

                    } header: {
                        Text("Contact")
                            .textCase(nil)

                    }

                    Section {

                        HStack {

                            HStack {

                                Text("Privacy agreement")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))

                                Spacer()
                                    .onTapGesture {

                                    withAnimation {


                                    }

                                }
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(.blue)
                                    .frame(
                                    alignment: .leading
                                )
                            }

                        }

                        HStack {

                            Text("User agreement")
                                .font(.system(size: 15, weight: .medium, design: .rounded))

                            Spacer()
                                .onTapGesture {

                                withAnimation {


                                }

                            }
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.blue)
                                .frame(
                                alignment: .leading
                            )
                        }



                    } header: {
                        Text("Privacy")
                            .textCase(nil)

                    }


                    Section {

                        HStack {

                            HStack {

                                Text("Language")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))

                                Spacer()
                                    .onTapGesture {

                                    withAnimation {


                                    }

                                }
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(.blue)
                                    .frame(
                                    alignment: .leading
                                )
                            }

                        }

                        HStack {

                            Text("Device")
                                .font(.system(size: 15, weight: .medium, design: .rounded))

                            Spacer()

                            Text(UIDevice().type.rawValue)
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundColor(.gray.opacity(0.75))
                        }

                        HStack {

                            Text("Version")
                                .font(.system(size: 15, weight: .medium, design: .rounded))

                            Spacer()


                            Text("v\(Bundle.main.releaseVersionNumber ?? "-")")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundColor(.gray.opacity(0.75))
                        }

                    } header: {
                        Text("System")
                            .textCase(nil)

                    }

                }


            }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Info")
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

    func openMailApp(toEmail: String, subject: String, body: String) {
        guard
            let subject = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let body = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            else {
            print("Error: Can't encode subject or body.")
            return
        }

        let urlString = "mailto:\(toEmail)?subject=\(subject)&body=\(body)"
        let url = URL(string: urlString)!

        UIApplication.shared.open(url)
    }

}

struct InfoPage_Previews: PreviewProvider {
    static var previews: some View {
        InfoPage()
    }
}
