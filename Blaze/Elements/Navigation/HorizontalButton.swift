//
//  TabLongButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/6/20.
//

import SwiftUI

struct HorizontalButton: View {
    
    private var symbol: String
    private var text: String
    private var desc: String
    
    init(symbol: String, text: String, desc: String) {
        self.symbol = symbol
        self.text = text
        self.desc = desc
    }
    
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .font(Font.body.weight(.regular))
                .foregroundColor(.blaze)

            Text(text)
                .foregroundColor(.blaze)

            Spacer()
            
            Text(desc)
                .foregroundColor(.secondary)
        }
        .padding(15)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 20)
    }
}
