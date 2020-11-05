//
//  NewsCard.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import URLImage

struct NewsCard: View {
    @State private var show = false
    var news: News
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(news.getTimeAgo().uppercased())
                .fontWeight(.semibold)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.blaze)
                .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                .padding([.horizontal, .top], 20)
                .padding(.bottom, 10)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(news.id)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    (Text(news.publisher)
                        .fontWeight(.regular)
                        .foregroundColor(.blaze)

                        + Text(" • " + news.author)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                    )
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
            .padding([.horizontal, .bottom], 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .opacity(show ? 1 : 0)
        .onAppear {
            withAnimation(Animation.easeInOut.delay(0.5)) {
                show = true
            }
        }
    }
}

struct NewsCard_Previews: PreviewProvider {
    static var previews: some View {
        let news = News(
            id: "Paul is stuck in anime, still stuck.",
            author: "Paul Wong",
            authorImg: "https://assets3.thrillist.com/v1/image/2855068/1200x630",
            authorBio: "Is an anime lover",
            content: "# Markdown Support\n---\n * Yessir\n\n<p style='color: orange'>HTML Support</p>",
            coverImage: "https://arc-anglerfish-arc2-prod-tbt.s3.amazonaws.com/public/BWRGAGGQUFAD5H6BQ2VRVKF6ZE.jpg",
            publisher: "Fox News",
            sourceURL: "https://quick-mass.netlify.app",
            date: Date(timeIntervalSinceNow: .pi)
        )
        return NewsCard(news: news)
    }
}
