//
//  HeaderButton.swift
//  HeaderButton
//
//  Created by Paul Wong on 8/22/21.
//

import SwiftUI

struct HeaderButton: View {
    
    private var title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack(spacing : 0) {
            Capsule()
                .fill(Color(.quaternaryLabel))
                .frame(width: 39, height: 5)
                .padding(.top, 7)
                .padding(.bottom, 11)
            
            HStack(spacing: 0) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Spacer()
            }
            .padding(.bottom, UIConstants.margin)
        }
        .padding(.horizontal, UIConstants.margin)
        .contentShape(Rectangle())
    }
}

struct FireHeaderButton: View {
    
    private var title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack(spacing : 0) {
            Capsule()
                .fill(Color(.quaternaryLabel))
                .frame(width: 39, height: 5)
                .padding(.top, 7)
                .padding(.bottom, 11)
            
            HStack(spacing: 0) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Spacer()
            }
            .padding(.bottom, UIConstants.margin)
        }
        .padding(.horizontal, UIConstants.margin)
        .contentShape(Rectangle())
    }
}
