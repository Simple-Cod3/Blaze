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
                        VStack {
                            Text("News Stories")
                                .fontWeight(.bold)
                                .font(.largeTitle)
                            Text("Latest collection")
                                .foregroundColor(.secondary)
                            Divider()
                        }.padding(20)
                        /// Must use i to keep the order intact
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
                VStack {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                    Text("Loading Stories...")
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
