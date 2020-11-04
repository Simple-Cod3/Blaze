//
//  LongButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/4/20.
//

import SwiftUI

struct LongButton: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .foregroundColor(.white)
                .font(.body)
            Spacer()
        }
        .padding(15)
        .background(Color.blaze)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
