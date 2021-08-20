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
                    .font(.title3)
                    .fontWeight(.semibold)
                
                if let description = description {
                    Text(description)
                        .font(.footnote)
                        .foregroundColor(.secondary.opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            
            Spacer()
        }
    }
}
