//
//  DragBar.swift
//  Blaze
//
//  Created by Paul Wong on 10/23/21.
//

import SwiftUI

struct DragBar: View {
    var body: some View {
        Capsule()
            .fill(Color(.quaternaryLabel))
            .frame(width: 39, height: 5)
            .padding(.top, 7)
            .padding(.bottom, 11)
    }
}

