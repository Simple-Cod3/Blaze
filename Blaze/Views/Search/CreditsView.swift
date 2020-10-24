//
//  CreditsView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
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

struct CreditsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Three curious students with a passion for code and design.")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 20)
                
                Link(destination: URL(string: "https://github.com/b0kch01")!) {
                    ProfileCircle(img: "b0kch01", name: "Nathan Choi", role: "Lead Developer", link: "github.com/b0kch01")
                }
                
                Link(destination: URL(string: "https://dribbble.com/polarizz")!) {
                    ProfileCircle(img: "polarizz", name: "Paul Wong", role: "Lead Designer", link: "dribbble.com/polarizz")
                }
                
                Link(destination: URL(string: "https://github.com/Sakend")!) {
                    ProfileCircle(img: "sakend", name: "Max Kerns", role: "Developer", link: "github.com/Sakend")
                }
                Spacer()
            }
        }
        .navigationBarTitle("Credits", displayMode: .large)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCircle(img: "b0kch01", name: "Nathan Choi", role: "Lead Developer", link: "github.com/b0kch01")
    }
}
