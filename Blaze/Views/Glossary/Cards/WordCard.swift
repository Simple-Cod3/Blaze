//
//  WordCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI

struct WordCard: View {
    
    @Environment(\.colorScheme) var colorScheme

    var term: Term
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 7) {
            Text(term.id)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Text(term.definition)
                .font(.subheadline)
                .foregroundColor(Color(.tertiaryLabel))
        }
        .padding(16)
        .background(colorScheme == .dark ? Color(.tertiarySystemFill) : Color(.tertiarySystemBackground).opacity(0.79))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}
