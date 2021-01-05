//
//  VerticalButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/8/20.
//

import SwiftUI

struct VerticalButton: View {
    var symbol: String
    var text: String
    var desc: String
    var mark: String
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Image(systemName: symbol)
                        .font(Font.body.weight(.regular))
                        .foregroundColor(.blaze)

                    Text(text)
                        .foregroundColor(.blaze)
                }
                
                Text(desc)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: mark)
                .font(Font.body.weight(.regular))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 20)
    }
}

struct VerticalButtoniPad: View {
    var symbol: String
    var text: String
    var desc: String
    var mark: String
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Image(systemName: symbol)
                        .font(Font.body.weight(.regular))
                        .foregroundColor(.blaze)

                    Text(text)
                        .foregroundColor(.blaze)
                }
                
                Text(desc)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: mark)
                .font(Font.body.weight(.regular))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 20)
    }
}
