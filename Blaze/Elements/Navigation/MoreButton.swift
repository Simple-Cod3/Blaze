//
//  MoreButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/6/20.
//

import SwiftUI

struct MoreButton: View {
    var symbol: String
    var text: String
    
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
