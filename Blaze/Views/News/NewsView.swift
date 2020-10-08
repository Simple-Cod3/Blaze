//
//  NewsView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import ModalView

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
    
    @State private var shown: NewsModals? = nil
    
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
                            HStack {
                                Header(title: "News", desc: "Latest national news and updates issued by the Incident Information System.")
                                Spacer()
                            }
                                .padding(.vertical, 20)

                            HStack {
                                Text("Resources")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 20)
                                Spacer()
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    
                                    ModalLink(destination: { PhoneView(dismiss: $0).environmentObject(phone) }) {
                                        HorizontalCard(imageString: "phone", title: "Emergency Numbers", subtitle: "Find the nearest fire stations")
                                    }.buttonStyle(CardButtonStyle())

                                    ModalLink(destination: GlossaryView()) {
                                        HorizontalCard(imageString: "glossary", title: "Glossary", subtitle: "Learn wildire terms")
                                    }.buttonStyle(CardButtonStyle())
                                    
                                }.padding(.horizontal, 20)
                            }
                            
                            HStack {
                                Text("Alerts")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 20)
                                Spacer()
                            }
                            ForEach(news.newsList.prefix(newsShown)) { news in
                                ModalLink(destination: { WebModal(dismiss: $0, url: news.url) }) {
                                    NewsCard(news: news)
                                }.buttonStyle(CardButtonStyle())
                            }
                            
                            if news.newsList.count > newsShown {
                                Button(action: {
                                    newsShown += 10
                                }) {
                                    Text("\(Image(systemName: "rectangle.stack.fill.badge.plus")) Show More")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 10)
                                        .background(Color.blaze)
                                        .clipShape(Capsule())
                                        .padding(.horizontal, 20)
                                }
                            }
                        }// VStack
                            .padding(.bottom, 20)
                    }// ScrollView
                    StatusBg()
                }
            }
            else if news.failed {
                failed
            }
            else {
                ProgressBarView(
                    progressObj: $news.progress,
                    progress: $progress,
                    done: $done.animation(.easeInOut),
                    text: "News"
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

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView().environmentObject(NewsBackend())
    }
}
