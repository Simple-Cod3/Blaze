//
//  FirePin.swift
//  FirePin
//
//  Created by Paul Wong on 8/23/21.
//

import SwiftUI

struct FirePin: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var showLabels: Bool
    
    var body: some View {
        Image(systemName: showLabels ? "" : "flame.fill")
            .font(.footnote)
            .foregroundColor(.blaze)
            .padding(7)
            .background(showLabels ? Color.blaze : (colorScheme == .dark ? Color(.tertiarySystemBackground) : Color.borderBackground))
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(colorScheme == .dark ? (Color.borderBackground) : Color(.tertiarySystemBackground), lineWidth: showLabels ? 0 : 2)
            )
    }
}
