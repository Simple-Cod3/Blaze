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
        .onAppear {
            show = false
            withAnimation(Animation.spring(response: 0.5).delay(0.1)) {
                show = true
            }
        }
    }
}
