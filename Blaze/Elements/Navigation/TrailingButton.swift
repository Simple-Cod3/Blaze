//
//  TrailingButton.swift
//  TrailingButton
//
//  Created by Paul Wong on 8/22/21.
//

import SwiftUI

struct TrailingButton: View {
    
    private var symbol: String
    
    init(_ symbol: String) {
        self.symbol = symbol
    }
    
    var body: some View {
        HStack(spacing: 0) {
            SymbolButton(symbol)
        }
        .padding([.vertical, .trailing], 20)
        .padding(.leading, 10)
        .contentShape(Rectangle())
    }
}
