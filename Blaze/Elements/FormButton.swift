//
//  LongButton.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
//

import SwiftUI

struct FormButton: View {
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