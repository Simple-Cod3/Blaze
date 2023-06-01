//
//  AQCard.swift
//  Blaze
//
//  Created by Paul Wong on 10/23/21.
//

import SwiftUI

struct AQCard<Content: View>: View {
    
    @Environment(\.colorScheme) var colorScheme

    private var symbol: String
    private var title: String
    private var status: String
    private var caption: String
    private var foreground: Color
    private var content: () -> Content

    init(symbol: String, title: String, status: String, caption: String, foreground: Color, @ViewBuilder content: @escaping () -> Content) {
        self.symbol = symbol
        self.title = title
        self.status = status
        self.caption = caption
        self.foreground = foreground
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            HStack(spacing: 5) {
                Image(systemName: symbol)
                
                Text(title)
            }
            .font(.callout.weight(.medium))
            .foregroundColor(foreground)
                
            HStack(spacing: 0) {
                content()
            
                Spacer()
                
                Text(status)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.tertiaryLabel))
            }
            
            Caption(caption)
        }
        .padding(16)
        .background(colorScheme == .dark ? Color(.tertiarySystemFill) : Color(.tertiarySystemBackground).opacity(0.79))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}
