//
//  Header2.swift
//  Blaze
//
//  Created by Nathan Choi on 9/7/20.
//

import SwiftUI

struct SubHeader: View {
    
    private var title: String
    private var desc: String
    
    init(title: String, desc: String) {
        self.title = title
        self.desc = desc
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.secondary.opacity(0.7))
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
    }
}
