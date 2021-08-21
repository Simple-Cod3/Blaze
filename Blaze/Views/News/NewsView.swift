//
//  NewsView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
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
        ModalPresenter {
            if done {
                ZStack(alignment: .top) {
                    ScrollView {
                        VStack(spacing: 20) {
                            Image("speaker").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 200)
                                .padding(40)
                            
                            Header(title: "News", desc: "Latest national news and updates issued by the Incident Information System.")
                                                        
                            ModalLink(destination: { PhoneView(dismiss: $0).environmentObject(phone) }) {
                                VerticalButton(symbol: "phone.circle", text: "Emergency Contacts", desc: "Find the nearest fire stations", mark: "chevron.up")
                            }
                            .buttonStyle(CardButtonStyle())
                            
                            ModalLink(destination: { GlossaryView(dismiss: $0) }) {
                                VerticalButton(symbol: "a.book.closed", text: "Glossary", desc: "Learn wildfire terms", mark: "chevron.up")
                            }
                            .buttonStyle(CardButtonStyle())
                            .padding(.top, -5)
                            
                            SubHeader(title: "Alerts", desc: "Latest news and alerts are sorted by time and in order.")

                            ForEach(news.newsList.prefix(newsShown)) { news in
                                NewsCardButton(news: news)
                            }
                            
                            if news.newsList.count > newsShown {
                                Button(action: {
                                    print(news.newsList.count)
                                    newsShown += 10
                                }) {
                                    MoreButton(symbol: "plus.circle", text: "Show More")
                                }
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    StatusBarBackground()
                }
            } else if news.failed {
                failed
            } else {
                ProgressBarView(
                    progressObjs: $news.progress,
                    progress: $progress,
                    done: $done.animation(.easeInOut)
                )
            }
        }
        .onAppear {
            if news.loaded {
                done = true
            }
        }
    }
}

struct NewsCardButton: View {
    @State var presenting = false
    var news: News
    
    var body: some View {
        Button(action: { presenting = true }) {
            NewsCard(news: news)
                .padding(.horizontal, 20)
                .contextMenu {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Button(action: { news.share(0) }) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }.disabled(true)
                    } else {
                        Button(action: { news.share(0) }) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                    }
                }
                .safariView(isPresented: $presenting) {
                    SafariView(
                        url: news.url,
                        configuration: SafariView.Configuration(
                            barCollapsingEnabled: true
                        )
                    )
                    .preferredControlAccentColor(Color.blaze)
                }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
