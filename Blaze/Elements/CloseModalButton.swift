//
//  CloseModalButton.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct CloseModalButton: View {
    var body: some View {
        Image(systemName: "xmark")
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(Color.secondary)
            .padding(8)
            .background(Color(.tertiarySystemFill))
            .clipShape(Circle())
    }
}

struct CloseModalButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseModalButton()
    }
}
