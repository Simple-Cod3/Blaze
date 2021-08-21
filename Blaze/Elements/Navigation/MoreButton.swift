//
//  MoreButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/6/20.
//

import SwiftUI

struct MoreButton: View {
    
    private var symbol: String
    private var text: String
    
    init(symbol: String, text: String) {
        self.symbol = symbol
        self.text = text
    }
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: symbol)
                .font(Font.callout.weight(.medium))

            Text(text)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .foregroundColor(.blaze)
        .padding(.vertical, 9)
        .padding(.horizontal, 13)
        .background(Color(.quaternarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 39, style: .continuous))
    }
}
