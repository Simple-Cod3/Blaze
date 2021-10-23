//
//  ProfileCircle.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct ProfileCircle: View {
    
    private var img: String
    private var name: String
    private var role: String
    private var link: String
    
    init(img: String, name: String, role: String, link: String) {
        self.img = img
        self.name = name
        self.role = role
        self.link = link
    }
    
    var body: some View {
        HStack(spacing: 5) {
            Image(img).resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 110, height: 110)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(.body.weight(.medium))
                    .foregroundColor(.primary)

                Text(role)
                    .foregroundColor(.secondary.opacity(0.7))
                    .font(.subheadline)

                Text(link)
                    .font(.subheadline)
                    .foregroundColor(.secondary.opacity(0.7))

            }
            
            Spacer()
        }
        .padding(9)
        .background(Color(.quaternarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
