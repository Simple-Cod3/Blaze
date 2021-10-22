//
//  NewsView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct NewsView: View {
    
    @EnvironmentObject var phone: PhoneBackend
    @EnvironmentObject var news: NewsBackend
    
    @State private var progress = 0.0
    @State private var done = false
    @State private var newsShown = 20
    @State private var shown: NewsModals?
    @State private var contacts = false
    @State private var glossary = false
    @State private var showDefinition = ""
    
    private enum NewsModals: String, Identifiable {
        var id: String { rawValue }
        case phone, glossary
    }
        
    @Binding var popup: Bool
    
    init(popup: Binding<Bool>) {
        self._popup = popup
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
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
            HeaderButton("News Overview")
                .padding(.bottom, popup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)
            
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
                .padding(.horizontal, UIConstants.margin)

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
                        .padding(.vertical, UIConstants.margin)

                    LazyVStack(spacing: 13) {
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
                .padding(UIConstants.margin)
                .padding(.bottom, UIConstants.bottomPadding*2)
                .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
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
