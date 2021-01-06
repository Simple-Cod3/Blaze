//
//  Header2.swift
//  Blaze
//
//  Created by Nathan Choi on 9/7/20.
//

import SwiftUI

struct SubHeader: View {
    
    var title: String
    var description: String?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.medium)
                
                if let description = description {
                    Text(description)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}
