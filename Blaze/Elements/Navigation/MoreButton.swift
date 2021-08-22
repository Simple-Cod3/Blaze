//
//  MoreButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/6/20.
//

import SwiftUI
import BetterSafariView

struct MoreButton: View {
    
    private var symbol: String
    private var text: String
    private var color: Color
    
    init(symbol: String, text: String, color: Color) {
        self.symbol = symbol
        self.text = text
        self.color = color
    }
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: symbol)
                .font(Font.callout.weight(.medium))

            Text(text)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .foregroundColor(color)
        .padding(.vertical, 9)
        .padding(.horizontal, 13)
        .background(Color(.quaternarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 39, style: .continuous))
    }
}

struct MoreButtonLink: View {
    
    @State private var presenting = false
    
    var url: URL
    
    private func toggle() { self.presenting.toggle() }
    
    var body: some View {
        Button(action: toggle) {
            HStack(spacing: 5) {
                Image(systemName: "ellipsis.circle")
                    .font(Font.callout.weight(.medium))

                Text("More Info")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .foregroundColor(.blaze)
            .padding(.vertical, 9)
            .padding(.horizontal, 13)
            .background(Color(.quaternarySystemFill))
            .clipShape(RoundedRectangle(cornerRadius: 39, style: .continuous))
        }
        .buttonStyle(DefaultButtonStyle())
        .sheet(isPresented: $presenting) {
            SafariViewBootleg(url: url)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
