//
//  RoundedButton.swift
//  Blaze
//
//  Created by Paul Wong on 10/20/20.
//

import SwiftUI

struct RoundedButton: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.blaze)
            .clipShape(Capsule())
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton("MAP")
    }
}
