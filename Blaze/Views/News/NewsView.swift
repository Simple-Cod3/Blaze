//
//  NewsView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import BetterSafariView

struct NewsView: View {
    
    @EnvironmentObject var phone: PhoneBackend
    @EnvironmentObject var news: NewsBackend
    
    @State private var progress = 0.0
    @State private var done = false
    @State private var newsShown = 20
    @State private var shown: NewsModals?
    @State var contacts = false
    @State var glossary = false
    @State var showDefinition = false
    
    private enum NewsModals: String, Identifiable {
        var id: String { rawValue }
        case phone, glossary
    }
        
    @Binding var popup: Bool
    
    init(popup: Binding<Bool>) {
        self._popup = popup
    }
    
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
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button(action: {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { popup.toggle() }
                }) {
                    HeaderButton(contacts ? "Contacts" : glossary ? "Glossary" : "News Overview", popup ? "chevron.down" : "chevron.up")
                        .padding(.trailing, glossary ? 0 : 20)
                }
                .buttonStyle(DefaultButtonStyle())
                
                Spacer()
                
                if glossary && popup {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                            if showDefinition {
                                showDefinition = false
                            } else {
                                glossary = false
                            }
                        }
                    }) {
                        TrailingButton("chevron.left")
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
            }

            if popup {
                if contacts {
                    PhoneView()
                } else if glossary {
                    GlossaryView(showDefinition: $showDefinition)
                } else {
                    newsdata
                }
            }
        }
    }
    
    private var newsdata: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 20)

            ScrollView {
                VStack(spacing: 0) {
//                    Button(action: {
//                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { contacts = true }
//                    }) {
//                        VerticalButton(
//                            symbol: "phone.circle",
//                            text: "Emergency Contacts",
//                            desc: "Find the nearest fire stations",
//                            mark: "chevron.right",
//                            color: .orange
//                        )
//                    }
//                    .buttonStyle(DefaultButtonStyle())
//                    .padding(.bottom, 13)
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { glossary = true }
                    }) {
                        VerticalButton(
                            symbol: "character.book.closed.fill",
                            text: "Glossary",
                            desc: "Learn wildfire terms",
                            mark: "chevron.right",
                            color: .orange
                        )
                    }
                    .buttonStyle(DefaultButtonStyle())
                    
                    SubHeader(title: "Alerts", desc: "Latest news and alerts are sorted by time and in order.")
                        .padding(.top, 20)
                        .padding(.bottom, 16)

                    VStack(spacing: 13) {
                        ForEach(news.newsList.prefix(newsShown)) { news in
                            NewsCardButton(news: news)
                        }
                        
                        if news.newsList.count > newsShown {
                            Button(action: {
                                print(news.newsList.count)
                                newsShown += 20
                            }) {
                                MoreButton(symbol: "plus.circle", text: "Show More", color: .orange)
                            }
                        }
                    }
                }
                .padding(20)
            }
        }
        
//        } else if news.failed {
//            failed
//        } else {
//            ProgressBarView(
//                progressObjs: $news.progress,
//                progress: $progress,
//                done: $done.animation(.easeInOut)
//            )
//        }
//    }
//    .onAppear {
//        if news.loaded {
//            done = true
//        }
//    }
    }
}

struct NewsCardButton: View {
    
    @State var presenting = false
    var news: News
    
    var body: some View {
        Button(action: { presenting = true }) {
            NewsCard(news: news)
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
                    .preferredControlAccentColor(Color.orange)
                }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
