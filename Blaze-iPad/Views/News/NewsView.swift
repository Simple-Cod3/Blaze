//
//  NewsView.swift
//  Blaze-iPad
//
//  Created by Paul Wong on 10/26/20.
//

import SwiftUI
import ModalView
import BetterSafariView

struct NewsView: View {
    @EnvironmentObject var phone: PhoneBackend
    @EnvironmentObject var news: NewsBackend
    @State private var progress = 0.0
    @State private var done = false
    @State private var newsShown = 10
    
    private enum NewsModals: String, Identifiable {
        var id: String { rawValue }
        case phone, glossary
    }
    
    @State private var shown: NewsModals?
    
    var failed: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 30))
                .foregroundColor(.blaze)
            
            Text("No Connection")
                .font(.title)
                .fontWeight(.bold)
            
            Button("Click to Retry", action: { news.refreshNewsList() })
        }
    }
    
    var body: some View {
        HStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image("speaker").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .padding(.vertical, 50)
                    
                    HStack {
                        Header(title: "News", desc: "Latest national news and updates issued by the Incident Information System.")
                        Spacer()
                    }
                }
                .padding(.bottom, 20)
                
                VStack(spacing: 20) {
                    ModalLink(destination: { PhoneView(dismiss: $0).environmentObject(phone) }) {
                        HorizontalCard(title: "Emergency Contacts", subtitle: "Find the nearest fire stations")
                    }.buttonStyle(CardButtonStyle())
                    
                    ModalLink(destination: { GlossaryView(dismiss: $0) }) {
                        HorizontalCard(title: "Glossary", subtitle: "Learn wildfire terms")
                    }.buttonStyle(CardButtonStyle())
                }
                .padding(.bottom, 80)
            }
            .frame(width: UIScreen.main.bounds.width/3)
            .background(Color(.secondarySystemBackground))
            
            Spacer()
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(news.newsList.prefix(newsShown)) { news in
                        NewsCardButton(news: news)
                    }
                    
                    if news.newsList.count > newsShown {
                        Button(action: {
                            newsShown += 10
                        }) {
                            Text("\(Image(systemName: "rectangle.stack.fill.badge.plus")) Show More")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 15)
                                .background(Color.blaze)
                                .clipShape(Capsule())
                                .padding(.horizontal, 20)
                        }
                    }
                }
                .padding(.top, 40)
            }
            .padding(.bottom, 70)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct NewsCardButton: View {
    @State var presenting = false
    var news: News
    
    var body: some View {
        Button(action: { presenting = true }) {
            NewsCard(news: news)
                .safariView(isPresented: $presenting) {
                    SafariView(
                        url: news.url,
                        configuration: SafariView.Configuration(
                            entersReaderIfAvailable: true,
                            barCollapsingEnabled: true
                        )
                    )
                    .preferredControlAccentColor(Color.blaze)
                }
        }
        .buttonStyle(CardButtonStyle())
    }
}

