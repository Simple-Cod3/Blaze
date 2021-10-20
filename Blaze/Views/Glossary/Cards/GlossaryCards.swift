//
//  GlossaryCard.swift
//  Blaze
//
//  Created by Paul Wong on 8/21/21.
//

import SwiftUI

struct GlossaryCards: View {
    
    @Binding var showDefinition: String
    var value: ScrollViewProxy

    var letters = Array(GlossaryDatabase.terms.keys).sorted()
    var glossary = GlossaryDatabase.terms
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        if showDefinition == "" {
            LazyVStack(spacing: 13) {
                ForEach(letters, id: \.self) { letter in
                    Button(action: {
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                            showDefinition = letter
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation {
                                value.scrollTo(0)
                            }
                        }
                    }) {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 0) {
                                (Text(letter.uppercased()) +
                                    Text(letter.lowercased()))
                                    .foregroundColor(.orange)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                                
                                (Text(glossary[letter]![0].id) + Text(" • " + glossary[letter]![1].id))
                                    .font(.system(size: textSize(textStyle: .subheadline)-1).weight(.medium))
                                    .foregroundColor(Color(.tertiaryLabel))
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            SymbolButton("chevron.right")

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
            ForEach(letters.filter { $0 == showDefinition }, id: \.self) { letter in
                VStack(spacing: 0) {
                    (Text(letter.uppercased()) +
                        Text(letter.lowercased()))
                        .font(.system(size: 59))
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .fixedSize()
                        .padding(.bottom, UIConstants.margin)
                        .id(0)
                    
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
