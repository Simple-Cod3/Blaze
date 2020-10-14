//
//  Header.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI

struct Header: View {
    private var title: String
    private var desc: String?
    private var hColor: Color
    private var padding: CGFloat
    
    init(title: String, desc: String? = nil, headerColor: Color = .blaze, padding: CGFloat = 20) {
        self.title = title
        self.desc = desc
        self.hColor = headerColor
        self.padding = padding
    }
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.system(size: 60))
                .fontWeight(.semibold)
                .foregroundColor(hColor)
            
            if let desc = desc {
                Text(desc)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, padding)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(title: "Big Fires", desc: "The US Forest Service is in unified command with CAL FIRE on the Elkhorn Fire, which is burning in the Tomhead Mountain area west of Red Bluff.")
    }
}
