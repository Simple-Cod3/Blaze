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
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 60))
                    .fontWeight(.semibold)
                    .foregroundColor(hColor)
                
                if let desc = desc {
                    Text(desc)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding(.horizontal, padding)
    }
}
