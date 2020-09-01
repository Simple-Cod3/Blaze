//
//  CloseModalButton.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct CloseModalButton: View {
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .font(.system(size: 25, weight: .semibold))
            .foregroundColor(Color(.systemFill))
    }
}

struct CloseModalButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseModalButton()
    }
}
