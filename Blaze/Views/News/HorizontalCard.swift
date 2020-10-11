//
//  BigNewsCard.swift
//  Blaze
//
//  Created by Nathan Choi on 9/27/20.
//

import SwiftUI

struct HorizontalCard: View {
    @State var show = false
    
    var title: String
    var subtitle: String
    
    init(newsObject: News, subtitle: String) {
        self.title = newsObject.id
        self.subtitle = subtitle
    }
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            Text(subtitle)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
        }
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(.leading, show ? 0 : UIScreen.main.bounds.maxX)
        .onAppear { withAnimation(.spring()) { show = true } }
    }
}
