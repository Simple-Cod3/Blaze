//
//  ProfileCircle.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct ProfileCircle: View {
    var img: String
    var name: String
    var role: String
    var link: String
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image(img).resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.leading, 20)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(role)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                    Text(name)
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    Text(link)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                    
                }
                Spacer()
            }
            .padding(.vertical, 20)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding(.horizontal, 20)
        }
    }
}
