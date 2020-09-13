//
//  ProgressBar.swift
//  Blaze
//
//  Created by Nathan Choi on 9/13/20.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader { g in
            ZStack(alignment: .leading) {
                Color.blaze.opacity(0.3)
                Color.blaze
                    .frame(width: g.size.width*CGFloat(min(self.progress, 1.0)))
            }
                .frame(height: 4)
                .clipShape(RoundedRectangle(cornerRadius: 2, style: .continuous))
                .animation(Animation.spring(dampingFraction: 0.5), value: self.progress)
        }.frame(height: 4)
    }
}
