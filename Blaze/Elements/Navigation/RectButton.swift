//
//  RectButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/8/20.
//

import SwiftUI

struct RectButton: View {
    
    @State var selected = false
    
    private var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(text)
                .font(.subheadline)
                .fontWeight(selected ? .bold : .medium)
                .foregroundColor(.primary.opacity(selected ? 1 : 0.7))
            
            Spacer()
        }
        .padding(.vertical, 9)
        .background(selected ? Color(.tertiarySystemBackground) : Color(.quaternarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
    }
}
