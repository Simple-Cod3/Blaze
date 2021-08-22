//
//  NewsCard.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct NewsCard: View {
        
    var news: News
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(news.id)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            HStack(spacing: 0) {
                Text(news.publisher)
                    .font(Font.subheadline.weight(.medium))
                    .foregroundColor(.orange)
             
                Spacer()
                
                Text(news.getTimeAgo().uppercased())
                    .font(Font.footnote.weight(.medium))
                    .foregroundColor(Color(.tertiaryLabel))

            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(16)
        .background(Color(.quaternarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}
