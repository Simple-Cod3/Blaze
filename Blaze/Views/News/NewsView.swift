//
//  NewsView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import ModalView

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
                        }
                            .padding(.top, 20)
                        
                        Divider().padding(20)

                        ForEach(news.newsList) { news in
                            ModalLink(destination: { WebModal(dismiss: $0, url: news.url) }) {
                                NewsCard(news: news)
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
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
