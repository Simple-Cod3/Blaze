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
    @State var progress = 0.0
    @State var done = false
    
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

                            ForEach(news.newsList) { news in
                                ModalLink(destination: { WebModal(dismiss: $0, url: news.url) }) {
                                    NewsCard(news: news)
                                }.buttonStyle(CardButtonStyle())
                            }
                        }
                    }
                    StatusBg()
                }
            }
            else if news.failed {
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
            else {
                ProgressBarView(
                    progressObj: $news.progress,
                    progress: $progress,
                    done: $done.animation(.easeInOut),
                    text: "News"
                )
            }
        }.onAppear {
            if news.loaded {
                done = true
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
