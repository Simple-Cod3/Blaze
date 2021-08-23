//
//  SymbolButton.swift
//  SymbolButton
//
//  Created by Polarizz on 8/21/21.
//

import SwiftUI

struct SymbolButton: View {
    
    private var symbol: String
    
    init(_ symbol: String) {
        self.symbol = symbol
    }
    
    var body: some View {
        Image(systemName: symbol)
            .font(.callout.bold())
            .foregroundColor(Color(.tertiaryLabel))
            .contentShape(Rectangle())
    }
}
