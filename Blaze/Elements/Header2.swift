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
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                
                if let description = description {
                    Text(description)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }.padding(.horizontal, 20)
    }
}
