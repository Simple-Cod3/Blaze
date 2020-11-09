//
//  TabLongButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/6/20.
//

import SwiftUI

struct HorizontalButton: View {
    var symbol: String
    var text: String
    var desc: String
    
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
