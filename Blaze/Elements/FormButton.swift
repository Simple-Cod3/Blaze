//
//  LongButton.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
//

import SwiftUI
import BetterSafariView

struct FormButton: View {
    @State private var on = false
    var text: String
    var url: URL
    
    private func toggle() { self.on.toggle() }
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: toggle) {
                Text(text)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .sheet(isPresented: $on) {
            SafariViewBootleg(url: url)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct FormButtonDirect: View {
    var text: String
    var url: URL
    
    var body: some View {
        HStack {
            Spacer()
            Link(destination: url) {
                Text(text)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            Spacer()
        }
    }
}

struct LongButton_Previews: PreviewProvider {
    static var previews: some View {
        FormButton(text: "Navigation", url: URL(string: "https://google.com")!)
    }
}
