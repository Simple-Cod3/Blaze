//
//  DataSection.swift
//  DataSection
//
//  Created by Paul Wong on 8/21/21.
//

import SwiftUI

struct DataSection: View {
    
    private var symbol: String
    private var unit: String
    private var data: String
    
    init(symbol: String, unit: String, data: String) {
        self.symbol = symbol
        self.unit = unit
        self.data = data
    }
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: symbol)
                .font(Font.body.weight(.medium))
                .foregroundColor(.blaze)
            
            Text(unit + ": ")
                .fontWeight(.medium)
                .foregroundColor(.blaze)
            + Text(data)
                .foregroundColor(.secondary.opacity(0.7))
        }
    }
}
