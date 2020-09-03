//
//  NewsArticleView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import URLImage

struct NewsArticleView: View {
    var dismiss: () -> ()
    var news: News
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 50) {
                    Text(news.id)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal, 20)
                    HStack(spacing: 20) {
                        URLImage(URL(string: news.authorImg ?? "https://www.solidbackgrounds.com/images/1920x1080/1920x1080-amber-orange-solid-color-background.jpg")!,
                                 placeholder: {_ in Color.orange.aspectRatio(contentMode: .fill)},
                                 failure: {_ in Color.orange.aspectRatio(contentMode: .fill)}
                        ) { proxy in
                            proxy.image.renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                            .animation(.easeOut)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                        
                        VStack(alignment: .leading) {
                            Text(news.author)
                                .font(.headline)
                                
                            Text(news.authorBio)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()

                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 20))
                        }
                    }
                        .padding(.horizontal, 20)
                        .background(Color(.secondarySystemGroupedBackground))
                        .transition(.opacity)
                        .animation(Animation.spring())
                    
                    HStack {
                        Spacer()
                        Image(systemName: "arrow.down")
                            .foregroundColor(.orange)
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                    }
                    
                    ArticleContent(data: news.content)
                        .padding(.leading, 20)
                        .padding(.trailing, 15)
                    Spacer()
                    Divider()
                }
            }
            .accentColor(.orange)
            .navigationBarTitle("News Story", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: dismiss) {
                CloseModalButton()
            })
            
        }
    }
}
 
