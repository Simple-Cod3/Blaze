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
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 7)
        .background(Color.blaze)
        .cornerRadius(20)
    }


}

struct InfoButton_Previews: PreviewProvider {
    static var previews: some View {
        InfoButton()
    }
}
