//
//  Hero.swift
//  Hero
//
//  Created by Paul Wong on 8/19/21.
//

import SwiftUI

struct Hero: View {
    
    private var symbol: String
    private var title: String
    private var desc: String
    private var color: Color
    
    init(_ symbol: String, _ title: String, _ desc: String, _ color: Color) {
        self.symbol = symbol
        self.title = title
        self.desc = desc
        self.color = color
    }
    
    var body: some View {
        HStack(spacing: 0) {
            
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Image(systemName: symbol)
                        .font(.body.bold())
                        .foregroundColor(.white)
                    
                    Text(title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                
                Text(desc)
                    .font(.callout)
                    .foregroundColor(.white.opacity(0.7))
            }
            Spacer()
        }
        .padding(20)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(20)
    }
}
