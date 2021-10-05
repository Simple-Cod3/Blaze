//
//  Caption.swift
//  Blaze
//
//  Created by Paul Wong on 11/6/20.
//

import SwiftUI

struct Caption: View {
    var text: String

    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(text)
                .font(.caption)
                .fontWeight(.regular)
                .foregroundColor(Color(.tertiaryLabel))
            
            Spacer()
        }
    }
}
