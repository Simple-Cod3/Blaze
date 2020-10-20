//
//  StatusBg.swift
//  Blaze
//
//  Created by Nathan Choi on 9/20/20.
//

import SwiftUI

struct StatusBarBackground: View {
    var body: some View {
        GeometryReader { g in
            VStack {
                Color(.systemBackground)
                    .frame(height: g.safeAreaInsets.top)
                    .edgesIgnoringSafeArea(.top)
                Spacer()
            }
        }
    }
}
