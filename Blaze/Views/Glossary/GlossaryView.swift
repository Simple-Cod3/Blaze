//
//  GlossaryView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
//

import SwiftUI

struct GlossaryView: View {
    
    @ObservedObject var bar = SearchBar()
    
    @State var wordsList = [Term]()
    
    @Binding var showDefinition: String
    @Binding var secondaryPopup: Bool
    @Binding var secondaryClose: Bool
    
    var letters = Array(GlossaryDatabase.terms.keys).sorted()
    var terms = GlossaryDatabase.getAllWords().sorted()
    
    private func getWords() {
        DispatchQueue.main.async {
            let query = bar.text.lowercased()
            
            self.wordsList = self.terms.filter {
                query.isEmpty ||
                $0.id.lowercased().contains(query)
            }.sorted()
        }
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
            
    var body: some View {
        VStack(spacing: 0) {
            SecondaryHeaderButton(secondaryClose: $secondaryClose, "Glossary")
                .padding(.bottom, secondaryPopup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)
                
            Divider()
                .padding(.horizontal, UIConstants.margin)

            ScrollView {
                ScrollViewReader { value in
                    VStack(spacing: 0) {
                        GlossaryCards(showDefinition: $showDefinition, value: value)
                    }
                    .onAppear { getWords() }
                    .padding(UIConstants.margin)
                    .padding(.bottom, UIConstants.bottomPadding)
                    .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
                }
            }
        }
    }
}
