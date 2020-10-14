//
//  Header2.swift
//  Blaze
//
//  Created by Nathan Choi on 9/7/20.
//

import SwiftUI

struct Header2: View {
    var title: String
    var description: String?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.title)
                    .fontWeight(.medium)
                
                if let description = description {
                    Text(description)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }.padding(.horizontal, 20)
    }
}
