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
                        .foregroundColor(.secondary)
                    
                    Text(name)
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    Text(link)
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
