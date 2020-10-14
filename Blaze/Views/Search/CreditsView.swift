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
        Button(action: {}) {
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
                        .foregroundColor(.white)
                    Text(role)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    
                }
                Spacer()
            }
            .padding(.vertical, 20)
            .background(Color.blaze)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding(.horizontal, 20)
        }.buttonStyle(CreditsButtonStyle())
    }
}

struct CreditsView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                Spacer()
                
                Header(title: "Credits", desc: "Three curious students with a passion for code and design.").padding(.top, 20)
                    .animation(.spring())
                
                ProfileCircle(img: "b0kch01", name: "Nathan Choi", role: "Lead Developer")
                ProfileCircle(img: "polarizz", name: "Paul Wong", role: "Lead Designer")
                ProfileCircle(img: "sakend", name: "Max Kerns", role: "Junior Developer")
                
                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
