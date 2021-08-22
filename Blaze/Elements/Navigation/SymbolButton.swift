//
//  SymbolButton.swift
//  SymbolButton
//
//  Created by Polarizz on 8/21/21.
//

import SwiftUI

struct SymbolButton: View {
    
    private var symbol: String
    private var color: Color
    
    init(_ symbol: String, _ color: Color) {
        self.symbol = symbol
        self.color = color
    }
    
    var body: some View {
        Image(systemName: symbol)
            .font(.callout.bold())
            .foregroundColor(color)
            .contentShape(Rectangle())
    }
}

