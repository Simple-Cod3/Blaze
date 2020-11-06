//
//  TabLongButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/6/20.
//

import SwiftUI

struct TabLongButton: View {
    var symbol: String
    var text: String
    var background: Color
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: symbol)
                .font(Font.body.weight(.regular))

            Text(text)
            Spacer()
        }
        .foregroundColor(.blaze)
        .padding(12)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
