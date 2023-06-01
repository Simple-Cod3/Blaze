//
//  NavigationButton.swift
//  Blaze
//
//  Created by Paul Wong on 5/26/23.
//

import SwiftUI

struct NavigationButton: View {

    private var symbol: String
    private var color: Color

    private var action: (() -> Void)?

    init(symbol: String, color: Color = Color.blaze, action: (() -> Void)?=nil) {
        self.symbol = symbol
        self.color = color
        self.action = action
    }

    var body: some View {
        Button(action: { action?() }) {
            Image(systemName: symbol)
                .font(.title3.weight(.medium))
                .frame(width: 18, height: 18)
                .foregroundColor(.secondary)
                .padding(9)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .contentShape(Rectangle())
        }
    }
}

struct NavigationButtonSelection: View {

    private var symbol: String
    private var foreground: Color
    private var background: Color

    private var action: (() -> Void)?

    init(symbol: String, foreground: Color, background: Color, action: (() -> Void)?=nil) {
        self.symbol = symbol
        self.foreground  = foreground
        self.background  = background
        self.action = action
    }

    var body: some View {
        Button(action: { action?() }) {
            Image(systemName: symbol)
                .font(.title3.weight(.medium))
                .frame(width: 18, height: 18)
                .foregroundColor(foreground)
                .padding(13)
                .background(background)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .contentShape(Rectangle())
        }
    }
}
