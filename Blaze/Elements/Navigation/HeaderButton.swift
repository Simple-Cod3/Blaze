//
//  HeaderButton.swift
//  HeaderButton
//
//  Created by Paul Wong on 8/22/21.
//

import SwiftUI

struct HeaderButton: View {
    
    private var title: String
    private var symbol: String
    
    init(_ title: String, _ symbol: String) {
        self.title = title
        self.symbol = symbol
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Spacer()
            
            SymbolButton(symbol)
        }
        .padding([.vertical, .leading], 20)
        .contentShape(Rectangle())
    }
}
