//
//  LongButton.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
//

import SwiftUI
import BetterSafariView

struct FormButton: View {
    
    @State private var presenting = false
    var text: String
    var url: URL
    
    private func toggle() { self.presenting.toggle() }
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "ellipsis.circle")
                .font(.system(size: 16))
                .foregroundColor(.blaze)
            Button(action: toggle) {
                Text(text)
            }
            Spacer()
        }
        .sheet(isPresented: $presenting) {
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
