//
//  VersionTag.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct VersionTag: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack {
            Text(text)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(.black)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 7)
        .background(Color.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
