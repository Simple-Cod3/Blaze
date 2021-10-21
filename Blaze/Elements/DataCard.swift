//
//  DataCard.swift
//  Blaze
//
//  Created by Paul Wong on 10/20/21.
//

import SwiftUI

struct DataCard: View {
    
    @Environment(\.colorScheme) var colorScheme

    private var symbol: String
    private var symbolCaption: String
    private var text: String
    private var foreground: Color
    
    init(_ symbol: String, _ symbolCaption: String, _ text: String, _ foreground: Color) {
        self.symbol = symbol
        self.symbolCaption = symbolCaption
        self.text = text
        self.foreground = foreground
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Image(systemName: symbol)
                    
                    Text(symbolCaption)
                }
                .font(.system(size: textSize(textStyle: .subheadline)-1).weight(.medium))
                .foregroundColor(foreground)
                
                Text(text)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding(16)
        .background(colorScheme == .dark ? Color(.tertiarySystemFill) : Color(.tertiarySystemBackground).opacity(0.79))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}
