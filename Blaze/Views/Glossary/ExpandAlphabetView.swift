//
//  ExpandAlphabetView.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct ExpandAlphabetView: View {
    
    @State var expand = false
    @State var show = false
    
    var key: String
    var dismiss: () -> Void
    
    var glossary = GlossaryDatabase.terms
    
    var body: some View {
        NavigationLink(
            destination:
                ScrollView {
                    VStack(spacing: 20) {
                        (Text(key.uppercased()).foregroundColor(.blaze) +
                            Text(key.lowercased()).foregroundColor(Color.blaze.opacity(0.3)))
                            .font(.system(size: 80))
                            .fontWeight(.semibold)
                            .fixedSize()
                            .padding(.bottom, 40)
                        
                        ForEach(glossary[key]!) { term in
                            WordCard(term: term)
                                .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 20)
                }
                .navigationBarTitle("", displayMode: .large)
                .navigationBarItems(trailing: Button(action: dismiss) {
                    CloseModalButton()
                })
        ) {
            HStack {
                (Text(key.uppercased()).foregroundColor(.blaze) +
                    Text(key.lowercased()).foregroundColor(Color.blaze.opacity(0.3)))
                    .font(.system(size: 50))
                    .fontWeight(.semibold)
                    .fixedSize()
                    .padding(.trailing, 40)
                Spacer()
                
                (Text(glossary[key]![0].id) + Text(" • " + glossary[key]![1].id))
                .foregroundColor(.secondary)
                .lineLimit(1)
            }
            .padding(.leading, 20)
        }
    }
}
