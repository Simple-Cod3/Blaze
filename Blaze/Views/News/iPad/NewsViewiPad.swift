//
//  NewsViewiPad.swift
//  Blaze
//
//  Created by Paul Wong on 11/2/20.
//

import SwiftUI
import ModalView
import BetterSafariView

struct NewsViewiPad: View {
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
        ModalPresenter {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    Image("speaker").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 225)
                        .padding(.vertical, 85)
                    
                    VStack(spacing: 20) {
                        Header(title: "News", desc: "Latest national news and updates issued by the Incident Information System.")
                        
                        ModalLink(destination: { PhoneView(dismiss: $0).environmentObject(phone) }) {
                            HorizontalCardiPad(title: "Emergency Contacts", subtitle: "Find the nearest fire stations")
                        }.buttonStyle(CardButtonStyle())
                        
                        ModalLink(destination: { GlossaryView(dismiss: $0) }) {
                            HorizontalCardiPad(title: "Glossary", subtitle: "Learn wildfire terms")
                        }.buttonStyle(CardButtonStyle())
                    }
                    .padding(.bottom, 20)
                }
                .background(Color(.secondarySystemBackground))
                .navigationBarTitle("", displayMode: .inline)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(news.newsList.prefix(newsShown)) { news in
                            NewsCardButton(news: news)
                        }
                        
                        if news.newsList.count > newsShown {
                            Button(action: {
                                newsShown += 10
                            }) {
                                MoreButton(symbol: "plus.circle", text: "Show More")
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
                .navigationBarTitle("News", displayMode: .inline)
            }
        }
    }
}
