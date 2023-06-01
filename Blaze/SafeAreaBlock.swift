//
//  SafeAreaBlock.swift
//  Blaze
//
//  Created by Paul Wong on 5/29/23.
//

import SwiftUI

struct SafeAreaBlock: View {

    @Environment(\.colorScheme) private var colorScheme

    private let height: CGFloat = 150

    var body: some View {
        GeometryReader { geometry in
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
                .frame(
                    width: 9999,
                    height: height + geometry.safeAreaInsets.top/1.5
                )
                .padding(.horizontal, -200)
                .blur(radius: 10)
                .contrast(colorScheme == .dark ? 1.24 : 1.07)
                .saturation(2)
                .ignoresSafeArea()
                .offset(y: -height/1.15)
                .ignoresSafeArea()
                .allowsHitTesting(false)
        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
