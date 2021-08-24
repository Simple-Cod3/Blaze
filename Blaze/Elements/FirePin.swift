//
//  FirePin.swift
//  FirePin
//
//  Created by Paul Wong on 8/23/21.
//

import SwiftUI

struct FirePin: View {
    var body: some View {
        Circle()
            .frame(width: 15, height: 15)
            .foregroundColor(Color.blaze)
            .padding(3)
            .background(Color.borderBackground)
            .clipShape(Circle())
    }
}
