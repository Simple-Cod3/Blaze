//
//  VerticalButton.swift
//  Blaze
//
//  Created by Paul Wong on 11/8/20.
//

import SwiftUI

struct VerticalButton: View {
    
    @Environment(\.colorScheme) var colorScheme

    private var symbol: String
    private var text: String
    private var desc: String
    private var mark: String
    private var color: Color
    
    init(symbol: String, text: String, desc: String, mark: String, color: Color) {
        self.symbol = symbol
        self.text = text
        self.desc = desc
        self.mark = mark
        self.color = color
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Image(systemName: symbol)
                        .foregroundColor(color)

                    Text(text)
                        .foregroundColor(color)
                }
                .font(Font.callout.weight(.medium))
                
                Text(desc)
                    .font(.system(size: textSize(textStyle: .subheadline)-1).weight(.medium))
                    .fontWeight(.medium)
                    .foregroundColor(Color(.tertiaryLabel))
            }
            
            Spacer()
            
            SymbolButton(mark)
        }
        .padding(16)
        .background(colorScheme == .dark ? Color(.tertiarySystemFill) : Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}
