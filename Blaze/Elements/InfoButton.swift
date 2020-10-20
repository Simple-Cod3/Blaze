//
//  InfoButton.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
//

import SwiftUI

struct InfoButton: View {
    var body: some View {
        VStack {
            Text("INFO")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 5)
        .background(Color.blaze)
        .cornerRadius(20)
    }


}

struct InfoButton_Previews: PreviewProvider {
    static var previews: some View {
        InfoButton()
    }
}
