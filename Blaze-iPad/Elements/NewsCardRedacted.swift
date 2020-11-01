//
//  NewsCardRedacted.swift
//  Blaze-iPad
//
//  Created by Paul Wong on 11/1/20.
//

import SwiftUI

struct NewsCardRedacted: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Big News")
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
                    Text("news.id")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                    
                   Text("news.publisher")
                        .fontWeight(.regular)
                        .foregroundColor(.blaze)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
            .padding([.horizontal, .bottom], 20)
        }
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(.horizontal, 20)
    }
}
