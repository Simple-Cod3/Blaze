//
//  GlossaryCard.swift
//  Blaze
//
//  Created by Paul Wong on 8/21/21.
//

import SwiftUI

struct GlossaryCard: View {
    
    @Binding var showDefinition: Bool
    
    var letters = Array(GlossaryDatabase.terms.keys).sorted()
    var glossary = GlossaryDatabase.terms
    
    var body: some View {
        if !showDefinition {
            LazyVStack(spacing: 13) {
                ForEach(letters, id: \.self) { letter in
                    Button(action: {
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { showDefinition.toggle() }
                    }) {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 0) {
                                (Text(letter.uppercased()) +
                                    Text(letter.lowercased()))
                                    .foregroundColor(.orange)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                                
                                (Text(glossary[letter]![0].id) + Text(" • " + glossary[letter]![1].id))
                                    .font(Font.subheadline.weight(.medium))
                                    .foregroundColor(Color(.tertiaryLabel))
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            SymbolButton("chevron.right", Color(.tertiaryLabel))

                        }
                        .padding(16)
                        .background(Color(.quaternarySystemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
            }
        } else {
            ForEach(letters, id: \.self) { letter in
                VStack(spacing: 0) {
                    (Text(letter.uppercased()) +
                        Text(letter.lowercased()))
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .fixedSize()
                        .padding(.bottom, 40)
                    
                    LazyVStack(spacing: 13) {
                        ForEach(glossary[letter]!) { term in
                            WordCard(term: term)
                        }
                    }
                }
            }
        }
    }
}
