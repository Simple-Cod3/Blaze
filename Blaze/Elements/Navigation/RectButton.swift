//
//  RectButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/8/20.
//

import SwiftUI

struct RectButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var selected: Bool
    
    private var text: String
    
    init(selected: Binding<Bool>, _ text: String) {
        self._selected = selected
        self.text = text
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(text)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.primary.opacity(selected ? 1 : 0.7))
            
            Spacer()
        }
        .padding(.vertical, 9)
        .background(selected ? (colorScheme == .dark ? Color(.tertiaryLabel) : Color.white) : Color(.quaternarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
        .shadow(color: Color.black.opacity(selected ? 0.07 : 0), radius: 10)
    }
}
