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
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.title)
                    .fontWeight(.medium)
                
                if let description = description {
                    Text(description)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}
