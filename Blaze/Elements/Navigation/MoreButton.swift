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
        HStack {
            Image(systemName: symbol)
                .font(Font.body.weight(.regular))

            Text(text)
        }
        .foregroundColor(.blaze)
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color(.secondarySystemBackground))
        .clipShape(Capsule())
    }
}
