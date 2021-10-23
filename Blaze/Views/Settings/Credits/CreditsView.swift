//
//  CreditsView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
//

import SwiftUI

struct CreditsView: View {
    
    @State var show = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: show ? 20 : 400) {
                Text("Three curious students with a passion for code and design.")
                    .font(.subheadline)
                    .foregroundColor(.secondary.opacity(0.7))
                
                Link(destination: URL(string: "https://github.com/b0kch01")!) {
                    ProfileCircle(img: "choi", name: "Nathan Choi", role: "Lead Developer", link: "github.com/b0kch01")
                }
                
                Link(destination: URL(string: "https://dribbble.com/polarizz")!) {
                    ProfileCircle(img: "wong", name: "Paul Wong", role: "Lead Designer", link: "dribbble.com/polarizz")
                }
                
                Link(destination: URL(string: "https://github.com/Sakend")!) {
                    ProfileCircle(img: "kerns", name: "Max Kerns", role: "Developer", link: "github.com/Sakend")
                }
                
                Spacer()
            }
        }
        .navigationBarTitle("Credits", displayMode: .large)
        .onAppear {
            show = false
            withAnimation(Animation.spring(response: 0.5).delay(0.05)) {
                show = true
            }
        }
    }
}
