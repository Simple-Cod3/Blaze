//
//  GenericButton.swift
//  Blaze
//
//  Created by Nathan Choi on 11/4/20.
//

import SwiftUI

struct GenericButton: View {
    private var text: String?
    private var icon: String?
    private var color: Color
    
    init(_ text: String?=nil, icon: String?, color: Color? = .blaze) {
        self.text = text
        self.icon = icon
        self.color = color!
    }
    
    var body: some View {
        HStack {
            Spacer()
            if let icon = icon {
                Image(systemName: icon)
                    .font(Font.body.weight(.regular))
                    .foregroundColor(color)
            }
            if let text = text {
                Text(text)
                    .fontWeight(.regular)
                    .font(.body)
                    .foregroundColor(color)
            }
            Spacer()
        }
        .padding(.vertical, 12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct GenericButton_Previews: PreviewProvider {
    static var previews: some View {
        GenericButton("Hello", icon: "pin")
    }
}
