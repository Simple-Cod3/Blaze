//
//  BigNewsCard.swift
//  Blaze
//
//  Created by Nathan Choi on 9/27/20.
//

import SwiftUI

struct HorizontalCard: View {
    @State var show = false
    
    var imageString: String
    var title: String
    var subtitle: String
    
    init(newsObject: News, subtitle: String) {
        self.imageString = newsObject.coverImage
        self.title = newsObject.id
        self.subtitle = subtitle
    }
    
    init(imageString: String, title: String, subtitle: String) {
        self.imageString = imageString
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Image(imageString)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            Text(subtitle)
                .font(.headline)
                .foregroundColor(.secondary)
        }
            .frame(width: 250, height: 270)
            .padding(20)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding(.leading, show ? 0 : UIScreen.main.bounds.maxX)
            .onAppear { withAnimation(.spring()) { show = true } }
    }
}
