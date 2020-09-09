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
    
    var body: some View {
        HStack(spacing: 15) {
            Image(img).resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .shadow(radius: 10)
                .padding(.leading, 20)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blaze)
                Text(role)
                    .font(.title3)
                    .fontWeight(.semibold)
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

struct CreditsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Header(title: "Credits", desc: "Submission for the Congressional App Competition, 2020.").padding(.top, 20)
            
            Spacer()
            
            ProfileCircle(img: "b0kch01", name: "Nathan Choi", role: "Lead Developer")
            ProfileCircle(img: "polarizz", name: "Paul Wong", role: "Lead Designer")
            ProfileCircle(img: "b0kch01", name: "Max Kerns", role: "Junior Developer")
            
            Spacer()
        }.navigationBarTitle("", displayMode: .inline)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
