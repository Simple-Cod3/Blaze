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
    
    @Binding var secondaryClose: Bool
    
    private var title: String
    
    init(secondaryClose: Binding<Bool>, _ title: String) {
        self._secondaryClose = secondaryClose
        self.title = title
    }
    
    var body: some View {
        VStack(spacing: 0) {
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
                
                Button(action: {
                    withAnimation(.spring(response: 0.49, dampingFraction: 0.9)) {
                        secondaryClose = false
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(Color(.tertiaryLabel))
                        .contentShape(Rectangle())
                }
            }
            .padding(.bottom, UIConstants.margin)
        }
        .padding(.horizontal, UIConstants.margin)
        .contentShape(Rectangle())
    }
}
