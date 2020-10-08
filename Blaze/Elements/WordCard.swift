//
//  WordCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI

struct WordCard: View {
    var term: Term
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            Text(term.id)
                .font(.title)
                .fontWeight(.semibold)
            Text(term.definition)
                .font(.callout)
                .foregroundColor(.secondary)
        }
            .padding(20)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

struct WordCard_Previews: PreviewProvider {
    static var previews: some View {
        WordCard(term: Term(id: "Paul", definition: "A very interesting person. Why? It's because he is a designer. Just kidding."))
    }
}
