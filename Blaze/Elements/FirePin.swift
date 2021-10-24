//
//  FirePin.swift
//  FirePin
//
//  Created by Paul Wong on 8/23/21.
//

import SwiftUI

struct FirePin: View {
        
    @Binding var showLabels: Bool
    
    var body: some View {
        Image(systemName: showLabels ? "" : "flame.fill")
            .opacity(showLabels ? 0 : 1)
            .font(.footnote)
            .foregroundColor(.blaze)
            .padding(showLabels ? 5 : 7)
            .background(showLabels ? Color.blaze : Color.pinBackground)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.pinBorderBackground, lineWidth: showLabels ? 0 : 2)
            )
    }
}
