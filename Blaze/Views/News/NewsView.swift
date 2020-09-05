//
//  NewsView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import ModalView
import SwiftUIPullToRefresh

struct NewsView: View {
    @EnvironmentObject var news: NewsBackend
    
    var body: some View {
        ModalPresenter {
            if news.loaded {
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Header(title: "News", desc: "Latest news about forest fires. This page may become obsolete so that is a huge F in the chat am I right? Any truers in the chat?")
                            Spacer()
                        }.padding(.top, 20)
                        Divider().padding(20)
                        /// Must use `i` to keep the order intact
                        ForEach(news.newsList.indices, id: \.self) { i in
                            ModalLink(destination: {
                                NewsArticleView(dismiss: $0, news: news.newsList[i])
                            }) {
                                NewsCard(news: news.newsList[i])
                            }
                        }
                    }
                }
            } else {
                VStack(spacing: 10) {
                    ProgressView()
                    Text("Loading Stories...")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .onAppear {
            
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
