//
//  RectButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/8/20.
//

import SwiftUI

struct RectButton: View {
    
    private var text: String
    private var color: Color
    private var background: Color
    
    init(_ text: String, color: Color, background: Color) {
        self.text = text
        self.color = color
        self.background = background
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(text)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(color)
            
            Spacer()
        }
        .padding(.vertical, 7)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
